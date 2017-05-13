# Copyright 2017 Ken Hrovat
# Licensed under the MIT license

require 'sketchup.rb'
require 'logger'
require 'examples/sumlib'

module Examples
  module ZoomSensor

    def self._zoomsensor(sensor, logger)

      sensor_name = sensor[0].upcase      # LIKE "F12"
      sensor_type = sensor[1].upcase      # LIKE "SE"
      sensor_def  = "SAMS_#{sensor_type}" # LIKE "SAMS_SE"
      logger.debug("Finding #{sensor_def}-#{sensor_name}")

      dlist = Sketchup.active_model.definitions
      cdef = dlist[sensor_def]
      if cdef # test for nil (not found)
        if !cdef.instances.empty?
          # find object with name LIKE "SAMS_SE-F12"
          obj = cdef.instances.find {|i| i.name == "#{sensor_def}-#{sensor_name}" }
          puts "found #{sensor_def}-#{sensor_name}" unless obj.nil?
          logger.info("Found   #{sensor_def}-#{sensor_name}") unless obj.nil?
          #b = obj.bounds unless obj.nil?
          t = obj.transformation unless obj.nil?
        else
          obj = nil
          logger.info("Didn't find #{sensor_def}-#{sensor_name}")
        end
      end

      # Once the object is found, zoom extents around the entity:
      Sketchup.active_model.active_view.zoom(obj) unless obj.nil?

      # Select the object
      model = Sketchup.active_model
      sel = model.selection
      sel.add obj unless obj.nil?

      # Write sensor transform info to log file
      t.to_matrix_log(logger)

      # Just showing off here with regular expression matching
      dname = "SAMS_SE" # FIXME this might be just SAMS_ to get both SE and TSH?
      matches = dlist.find_all {|d|
        !d.group? && !d.image? && d.name =~ /\A(#{dname})/
      }
      total = 0
      matches.each {|definition|
        number = definition.count_used_instances
        next if number < 1
        total += number
        logger.info("Found #{total} sensors like '#{dname}' #{definition.name}")
      }

      #t.say_hello(logger)

    end

    def self.zoom_sensor
      # Zoom to SAMS SE (component)

      logger = Logger.new('/Users/ken/log/rubysketchup_zoomsensor.log', 10, 1024000)
      logger.level = Logger::DEBUG
      logger.info("-"*40)
      logger.debug("Created logger")
      logger.info("Program start")

      # Show the Ruby Console at startup so we can
      # see any programming errors we may make.
      SKETCHUP_CONSOLE.show

      mod = Sketchup.active_model # Open model
      #ent = mod.entities # All entities in model
      #sel = mod.selection # Current selection

      mod.start_operation('Zoom Sensor', true)

      # prompt for sensor name
      prompts =  ["Name", "Type"]
      defaults = ["F05",  "SE"]
      list =     ["",     "SE|TSH"]
      user_input = UI.inputbox(prompts, defaults, list, "Which Sensor?")

      if user_input[0] == "ALL"
        logger.info("ZOOMING ALL")
        (0..5).each { |f|
          (0..7).each { |p|
            inp = ["F#{f+1}#{p}", "SE"] # LIKE ["F37", "SE"]
            logger.info(inp)
            self._zoomsensor(inp, logger)
          }
        }

      else

        # Call our one-at-a-time method
        if user_input
          self._zoomsensor(user_input, logger)
        else
          puts "User hit cancel."
        end

      end

      logger.info("Program end")

      mod.commit_operation

    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('Zoom Sensor') {
        self.zoom_sensor
      }
      file_loaded(__FILE__)
    end

  end # module ZoomSensor
end # module Examples

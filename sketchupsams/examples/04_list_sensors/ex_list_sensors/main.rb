# Copyright 2017 Ken Hrovat
# Licensed under the MIT license

require 'sketchup.rb'
require 'logger'
require 'examples/sumlib'

module Examples
  module ListSensors

    def self._listsensors(senstype, logger)

      sensor_type = senstype[0].upcase    # LIKE "SE"      or "TSH"
      sensor_def  = "SAMS_#{sensor_type}" # LIKE "SAMS_SE" or "SAMS_TSH"
      logger.info("Finding #{sensor_def} among model definitions.")

      dlist = Sketchup.active_model.definitions
      cdef = dlist[sensor_def]
      if cdef # test for nil (not found)
        if !cdef.instances.empty?
          # find matches for like "SAMS_SE" or "SAMS_TSH"
          matches = cdef.instances { |d| !d.group? && !d.image? && d.name =~ /\A(#{dname})/ }
          puts "There are #{matches.length} matching #{sensor_def} instances."
          logger.info("There are #{matches.length} matching #{sensor_def} instances.")
          if !matches.empty?
              m = matches.sort { |x, y| x.name <=> y.name }
              m.each {|ins|
                ins_name = ins.name
                logger.info("Found #{ins_name}")
                t = ins.transformation
                t.to_matrix_log(logger)
              }
          end
        else
          logger.info("cdef instances empty")
        end
      else
        puts "There are no matching #{sensor_def} instances."
        logger.info("There are no matching #{sensor_def} instances.")
      end

    end

    def self.list_sensors

      logger = Logger.new('/Users/ken/log/rubysketchup_listsensors.log', 10, 1024000)
      logger.level = Logger::DEBUG
      logger.info('-'*40)
      logger.debug("Created logger")
      logger.info("Program start")

      # Show the Ruby Console at startup so we can
      # see any programming errors we may make.
      SKETCHUP_CONSOLE.show

      mod = Sketchup.active_model # Open model
      mod.start_operation('List Sensors', true)

      # prompt for sensor name
      prompts =  ["Type"]
      defaults = ["ALL"]
      list =     ["SE|TSH|ALL"]
      user_input = UI.inputbox(prompts, defaults, list, "Find what type?")

      if user_input[0] == "ALL"
        logger.info("Find ALL sensors...")
        self._listsensors(["SE"], logger)
        self._listsensors(["TSH"], logger)
      else
        if user_input
          self._listsensors(user_input, logger)
        else
          puts "User hit cancel."
        end
      end

      logger.info("Program end")

      mod.commit_operation

    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('List Sensors') {
        #puts $LOAD_PATH # show path in console window
        self.list_sensors
      }
      file_loaded(__FILE__)
    end

  end # module ListSensors
end # module Examples

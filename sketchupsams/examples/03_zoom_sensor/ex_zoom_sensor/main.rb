# Copyright 2017 Ken Hrovat
# Licensed under the MIT license

require 'sketchup.rb'
require 'logger'

class Geom::Transformation
  def to_matrix
    a = self.to_a
    f = "%8.3f"
    l = [f, f, f, f].join("  ") + "\n"
    str =  sprintf l,  a[0], a[1], a[2], a[3]
    str += sprintf l,  a[4], a[5], a[6], a[7]
    str += sprintf l,  a[8], a[9], a[10], a[11]
    str += sprintf l,  a[12], a[13], a[14], a[15]
    str
  end
  def to_matrix_log(logger)
    a = self.to_a
    f = "%8.3f"
    l = [f, f, f, f].join("  ")
    str1 =  sprintf l,  a[0], a[1], a[2], a[3]
    logger.info("#{str1}")
    str2 = sprintf l,  a[4], a[5], a[6], a[7]
    logger.info("#{str2}")
    str3 = sprintf l,  a[8], a[9], a[10], a[11]
    logger.info("#{str3}")
    str4 = sprintf l,  a[12], a[13], a[14], a[15]
    logger.info("#{str4}")
  end  
end

module Examples
  module ZoomSensor

    def self._zoomsensor(sensor, logger)

      sensor_name = sensor[0].upcase
      sensor_type = sensor[1].upcase
      sensor_def  = "SAMS_#{sensor_type}"
      logger.debug("Finding #{sensor_def}-#{sensor_name}")

      dlist = Sketchup.active_model.definitions
      cdef = dlist[sensor_def]
      if cdef # test for nil (not found)
        if !cdef.instances.empty?
          obj = cdef.instances.find {|i| i.name == "#{sensor_def}-#{sensor_name}" }
          puts "found #{sensor_def}-#{sensor_name}" unless obj.nil?
          logger.info("Found   #{sensor_def}-#{sensor_name}") unless obj.nil?     
          #b = obj.bounds unless obj.nil?
          t = obj.transformation unless obj.nil?
        else
          obj = nil
        end
      end

      # Once the object is found, zoom extents around the entity:
      Sketchup.active_model.active_view.zoom(obj) unless obj.nil?

      # Select the object
      model = Sketchup.active_model
      sel = model.selection
      sel.add obj unless obj.nil?

      # Show sensor origin & rotation
      #pt_origin = t.origin unless obj.nil?
      #x = t.xaxis unless obj.nil?
      #y = t.yaxis unless obj.nil?
      #z = t.zaxis unless obj.nil?

      # Show sensor transform matrix
      str_mat = t.to_matrix
      UI.messagebox "#{str_mat}" unless obj.nil?
      #logger.info("#{str_mat}")
      t.to_matrix_log(logger)     

    end

    def self.zoom_sensor
      # Zoom to SAMS SE (component)

      logger = Logger.new('/Users/ken/log/rubysketchup_zoomsensor.log', 10, 1024000)
      logger.level = Logger::DEBUG
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
            logger.info("SAMS_SE-F#{f+1}#{p}")
            self._zoomsensor(["#{f+1}#{p}", "SE"], logger)
          }
        }
        
      else

        # Call our new method.
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

# Copyright 2017 Ken Hrovat
# Licensed under the MIT license

require 'sketchup.rb'

module Examples
  module PutSensor

    # put new sensor at xyz location (SSA coords and orientation)
    def self._putsensor(newsensor)

      sensorname = newsensor[0].upcase
      x = newsensor[1].to_f
      y = newsensor[2].to_f
      z = newsensor[3].to_f

      # Load a SAMS SE component from file
      sensor_def = Sketchup.active_model.definitions.load("/Users/ken/Library/Application Support/SketchUp 2017/SketchUp/Components/sams/SAMS_SE.skp")
      # Define a location (the origin), and place our sensor there [with SSA orientation]
      sensor_location = Geom::Point3d.new x,y,z
      transform = Geom::Transformation.new sensor_location
      entities = Sketchup.active_model.active_entities
      instance = entities.add_instance sensor_def, transform
      instance.name = "SAMS_SE-#{sensorname}"

    end

    def self.put_sensor
      # Place SAMS SE (component)

      # Show the Ruby Console at startup so we can
      # see any programming errors we may make.
      SKETCHUP_CONSOLE.show

      mod = Sketchup.active_model # Open model
      ent = mod.entities # All entities in model
      sel = mod.selection # Current selection

      mod.start_operation('Put Sensor', true)

      # prompt for sensor name
      prompts =  ["Name", "XA", "YA", "ZA"]
      defaults = ["f00",  "0",  "0",  "0"]
      input = UI.inputbox(prompts, defaults, "New Sensor Location")

      # Call our new method.
      if input
        self._putsensor(input)
      else
        puts "User hit cancel."
      end

      mod.commit_operation

    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('Put Sensor') {
        self.put_sensor
      }
      file_loaded(__FILE__)
    end

  end # module PutSensor
end # module Examples

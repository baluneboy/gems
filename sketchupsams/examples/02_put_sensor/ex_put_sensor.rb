# Copyright 2017 Ken Hrovat
# Licensed under the MIT license

require 'sketchup.rb'
require 'extensions.rb'

module Examples
  module PutSensor

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Put Sensor', 'ex_put_sensor/main')
      ex.description = 'SketchUp Ruby API example put sensor.'
      ex.version     = '1.0.0'
      ex.copyright   = 'Ken Hrovat © 2017'
      ex.creator     = 'Ken Hrovat'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module PutSensor
end # module Examples

# Copyright 2017 Ken Hrovat
# Licensed under the MIT license

require 'sketchup.rb'
require 'extensions.rb'

module Examples
  module ColorBoxes

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Color Boxes', 'ex_color_boxes/main')
      ex.description = 'SketchUp Ruby API example color boxes.'
      ex.version     = '1.0.0'
      ex.copyright   = 'Ken Hrovat © 2017'
      ex.creator     = 'Ken Hrovat'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module ColorBoxes
end # module Examples

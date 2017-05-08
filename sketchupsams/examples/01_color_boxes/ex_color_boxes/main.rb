# Copyright 2017 Ken Hrovat
# Licensed under the MIT license

require 'sketchup.rb'

module Examples
  module ColorBoxes

    def self.create_color_boxes
      # Create a 3D grid of colored cubes

      mod = Sketchup.active_model # Open model
      ent = mod.entities # All entities in model
      sel = mod.selection # Current selection

      mod.start_operation('Create Color Boxes', true)

      n = 3   # number of cubes
      s = 80  # spacing
      w = 60  # width of cubes

      (0..n-1).each { |i|
        (0..n-1).each { |j|
          (0..n-1).each { |k|
            # create a group for each cube
            group = ent.add_group
            # add the face to the group’s entities
            face = group.entities.add_face [i*s,j*s,k*s],[i*s,j*s+w,k*s],[i*s+w,j*s+w,k*s], [i*s+w,j*s,k*s]
            # add material (an RGB color)
            face.back_material = [(255/n*i).round,(255/n*j).round,(255/n*k).round]
            # now extrude the cube
             face.pushpull(-w)
          }
        }
      }

      mod.commit_operation
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('Create Color Boxes') {
        self.create_color_boxes
      }
      file_loaded(__FILE__)
    end

  end # module ColorBoxes
end # module Examples

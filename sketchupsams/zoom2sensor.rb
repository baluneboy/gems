# load "/Users/ken/Library/Application Support/SketchUp 2016/SketchUp/Plugins/zoom2sensor.rb"

# First we pull in the standard API hooks.
require 'sketchup.rb'

# Show the Ruby Console at startup so we can
# see any programming errors we may make.
SKETCHUP_CONSOLE.show

# Add a menu item to launch our plugin.
UI.menu("PlugIns").add_item("Zoom To Sensor") {

  # prompt for sensor name
  prompts =  ["Name", "Type"]
  defaults = ["F05",  "SE"]
  list =     ["",     "SE|TSH"]
  user_input = UI.inputbox(prompts, defaults, list, "Which Sensor?")
  
  # Call our new method.
  if user_input
    getsensor(user_input)
  else
    puts "User hit cancel."
  end
}

def getsensor(sensor)

  sensor_name = sensor[0].upcase
  sensor_type = sensor[1].upcase
  sensor_def  = "SAMS_#{sensor_type}"

  dlist = Sketchup.active_model.definitions
  cdef = dlist[sensor_def]
  if cdef # test for nil (not found)
    if !cdef.instances.empty?
      obj = cdef.instances.find {|i| i.name == "#{sensor_def}-#{sensor_name}" }
      puts "found #{sensor_def}-#{sensor_name}" unless obj.nil?
      b = obj.bounds unless obj.nil?
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

  # Show its origin
  pt_origin = t.origin unless obj.nil?
  UI.messagebox pt_origin unless obj.nil?

  # Show its rotation
  x = t.xaxis unless obj.nil?
  y = t.yaxis unless obj.nil?
  z = t.zaxis unless obj.nil?
  UI.messagebox "#{x} #{y} #{z}" unless obj.nil?

end
# load "/Users/ken/Library/Application Support/SketchUp 2016/SketchUp/Plugins/putsensor.rb"

# First we pull in the standard API hooks.
require 'sketchup.rb'

# Show the Ruby Console at startup so we can
# see any programming errors we may make.
SKETCHUP_CONSOLE.show

# Add a menu item to launch our plugin.
UI.menu("PlugIns").add_item("Put new SE Sensor") {

  # prompt for sensor name
  prompts =  ["Name", "XA", "YA", "ZA"]
  defaults = ["f00",  "0",  "0",  "0"]
  input = UI.inputbox(prompts, defaults, "New Sensor Location")

  # Call our new method.
  if input
    putsensor(input)
  else
    puts "User hit cancel."
  end
}

# put new sensor at xyz location (SSA coords and orientation)
def putsensor(newsensor)

  sensorname = newsensor[0].upcase
  x = newsensor[1].to_f
  y = newsensor[2].to_f
  z = newsensor[3].to_f

  # Load a SAMS SE component from file
  sensor_def = Sketchup.active_model.definitions.load("/Users/ken/Library/Application Support/SketchUp 2016/SketchUp/SAMS_Components/SAMS_SE.skp")

  # Define a location (the origin), and place our sensor there [with SSA orientation]
  sensor_location = Geom::Point3d.new x,y,z
  transform = Geom::Transformation.new sensor_location
  entities = Sketchup.active_model.active_entities
  instance = entities.add_instance sensor_def, transform
  instance.name = "SAMS_SE-#{sensorname}"

end
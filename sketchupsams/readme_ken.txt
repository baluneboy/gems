# Created a ruby file in Plugins folder named:
/Users/ken/Library/Application Support/SketchUp 2017/SketchUp/Plugins/load_sams.rb
# where load_sams.rb has these next 2 lines:
$LOAD_PATH << '/Users/ken/dev/programs/ruby/gems/sketchupsams'
require 'load_examples.rb'

OLDER README STUFF:
Put a tag on component and use ruby to query position by tag.
Place a tagged component from file with expected orientation.
Use ruby to get orientation and location info on tagged component.
Refine SAMS SE model.

SAMS Sensor Entity Info
1. Definition will be "SAMS_SE" or "SAMS_TSH" for the component.
2. Individual sensors will be named like "SAMS_SE-F05" or "SAMS_TSH-ES06".

putsensor.rb - prompt for sensor info/location, then load component & place sensor as specified
zoom2sensor.rb - prompt for sensor name, then zoom to its location & add that sensor to Selection

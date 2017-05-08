mod = Sketchup.active_model # Open model
ent = mod.entities # All entities in model
sel = mod.selection # Current selection

angle = 45; 
origin = Sketchup.active_model.selection.first.transformation.origin
tr = Geom::Transformation.rotation(origin,[0,0,1],angle.degrees) 
Sketchup.active_model.active_entities.transform_entities(tr,sel)

# Grab every entity named "shoebox" in the selection: 
test3s = ent.collect { |entity| entity.name == "bonfire" } 

# We can assume there is exactly one of these, so: 
obj = test3s[0]

mod.active_view.zoom(obj) unless obj.nil?

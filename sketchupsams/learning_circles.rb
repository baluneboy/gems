mod = Sketchup.active_model # Open model
ent = mod.entities # All entities in model
sel = mod.selection # Current selection

# Draw a circle on the ground plane around the origin.
center_point = ORIGIN #Geom::Point3d.new(0,0,0)
normal_vector = Geom::Vector3d.new(0,0,1)
radius = 10
edgearray = ent.add_circle center_point, normal_vector, radius
first_edge = edgearray[0]
arccurve = first_edge.curve

# Create a circle perpendicular to the normal or Z axis
center_point = ORIGIN
vector = Geom::Vector3d.new 0,0,2
vector2 = vector.normalize!
edgearray = ent.add_circle center_point, vector2, 10
edge = edgearray[0]
arccurve = edge.curve
circle_cpoint = arccurve.center

# Create a 1/2 circle, normal to the Z axis
center = ORIGIN # Geom::Point3d.new
normal = Geom::Vector3d.new 0,0,1
xaxis = XAXIS # Geom::Vector3d.new 1,0,0
start_a = 0.0
end_a = Math::PI
edgearray = ent.add_arc center, xaxis, normal, 5, start_a, end_a
edge = edgearray[0]
arccurve = edge.curve
end_angle = arccurve.end_angle # angle of end of arc

# Create a circle perpendicular to the normal or Z axis
center_point = ORIGIN
vector = Geom::Vector3d.new 0,0,3
vector2 = vector.normalize!
edgearray = ent.add_circle center_point, vector2, 10
edge = edgearray[0]
arccurve = edge.curve
v = arccurve.normal # vector [normal to arccurve?]

# Create a circle perpendicular to the normal or Z axis
center = Geom::Point3d.new 0, 0, 1
vector = Geom::Vector3d.new 0,0,5
vector2 = vector.normalize!
edgearray = ent.add_circle centerpoint, vector2, 10
edge = edgearray[0]
arccurve = edge.curve
plane = arccurve.plane # plane of arc
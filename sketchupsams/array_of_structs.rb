
Z_AXIS = [ 0, 0, 1 ]
Y_AXIS = [ 0, 1, 0 ]
X_AXIS = [ 1, 0, 0 ]

# Define array of hashes for transform
array = [
   { :name => "YAW",   :angle =>   90, :rot_ax => Z_AXIS },
   { :name => "PITCH", :angle =>   45, :rot_ax => Y_AXIS },
   { :name => "ROLL",  :angle =>   30, :rot_ax => X_AXIS }
]

array.each_with_index { |tform, idx|
  puts "#{idx} #{tform[:name]}: #{tform[:angle]}"
}
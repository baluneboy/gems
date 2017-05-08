require 'sketchup.rb'
begin
	file__ = __FILE__
	file__ = file__.force_encoding("UTF-8") if defined?(Encoding)
	file__ = file__.gsub(/\\/, '/')
	curdir = File.dirname(file__)
	fput = File.join(curdir, "putsensor.rb")
	require fput	
	fzoom = File.join(curdir, "zoom2sensor.rb")
	require fzoom		
rescue LoadError
end

#***********************************************************************************************
# MODULE SAMS - Master code of the macro
#***********************************************************************************************

module SAMS

# EXECUTED ONCE - Startup procedure and add a menu choice for SAMS utils
unless $SAMS____loaded
	puts "hello"
	$SAMS____loaded = true
end

end # module SAMS

class Geom::Transformation
  def to_matrix
    a = self.to_a
    f = "%8.3f"
    l = [f, f, f, f].join("  ") + "\n"
    str =  sprintf l,  a[0], a[1], a[2], a[3]
    str += sprintf l,  a[4], a[5], a[6], a[7]
    str += sprintf l,  a[8], a[9], a[10], a[11]
    str += sprintf l,  a[12], a[13], a[14], a[15]
    str
  end
  def to_matrix_log(logger)
    a = self.to_a
    f = "%8.3f"
    l = [f, f, f, f].join("  ")
    str1 =  sprintf l,  a[0], a[1], a[2], a[3]
    logger.info("#{str1}")
    str2 = sprintf l,  a[4], a[5], a[6], a[7]
    logger.info("#{str2}")
    str3 = sprintf l,  a[8], a[9], a[10], a[11]
    logger.info("#{str3}")
    str4 = sprintf l,  a[12], a[13], a[14], a[15]
    logger.info("#{str4}")
  end
  def extract_euler(logger)
    a = self.to_a
    f = "%8.3f"
    l = [f, f, f].join("  ") + "  =  YPR (deg)\n"
    # d = [f, f, f].join("  ") + "  =  c2,s1,c1\n"

    # Scale factor to convert input angles from radians to degrees
    sf = 180.0/Math::PI

    # Extract first angle
    #roll = atan2(m(2,3), m(3,3)); % MATLAB
    roll = Math.atan2(a[6].round(3), a[10].round(3))

    # Intermediate calc [sidesteps gimbal lock situation?]
    #              see /Users/ken/matlab/euler-angles1.pdf
    #c2 = sqrt(m(1,1)^2 + m(1,2)^2); % MATLAB
    c2 = Math.sqrt( a[0].round(3)**2 + a[1].round(3)**2 )

    # Extract second angle
    #pitch = atan2(-m(1,3), c2); % MATLAB
    pitch = Math.atan2(-a[2].round(3), c2.round(3))

    # Two more intermediate calc
    s1 = Math.sin(roll.round(3))
    c1 = Math.cos(roll.round(3))

    # Extract third angle
    #yaw = atan2( s1*m(3,1) - c1*m(2,1), c1*m(2,2) - s1*m(3,2) ); % MATLAB
    yaw = Math.atan2( s1*a[8].round(3) - c1*a[4].round(3), c1*a[5].round(3) - s1*a[9].round(3) )

    str1 =  sprintf l,  yaw*sf, pitch*sf, roll*sf
    logger.info("#{str1}")

    # str2 = sprintf d, c2, s1, c1
    # logger.debug("#{str2}")

  end
  def say_hello(logger)
    puts "What up schnauzer?"
    logger.info("What up schnauzer?")
  end
end

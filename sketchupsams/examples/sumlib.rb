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
  def say_hello(logger)
    puts "What up schnauzer?"
    logger.info("What up schnauzer?")
  end
end

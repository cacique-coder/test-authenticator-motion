class AnimateImage < UIImageView
  def sprites
   ["s1.png", "s2.png", "s3.png", "s4.png",
    "s5.png", "s6.png", "s7.png", "s8.png",
    "s9.png", "s10.png", "s11.png", "s12.png",
    "s13.png", "s14.png", "s15.png", "s16.png","s17.png"]
  end

  def image_load(image_name)
    UIImage.imageNamed("images/sprites/#{name}")
  end

  def image_array
    sprites.map{|name| image_load(name) unless name.nil?}
  end

  def set_animation
    self.animationImages = image_array
#    self.animationDuration = 10
    self.contentMode = UIViewContentModeBottomLeft;
  end

  def self.create
    animated_image = alloc.initWithFrame([position,size_image]);
    animated_image.set_animation
    animated_image
  end

  def self.size_image
    [width_image,height_image]
  end

  def self.width_image
    32
  end

  def self.height_image
    100
  end

  def self.position
    array = UIScreen.mainScreen.bounds.to_a
    array[1][0] = array[1][0] - width_image
    array[1][1] = array[1][1] - height_image
    array[1].map{|i| i / 2 }
  end

end
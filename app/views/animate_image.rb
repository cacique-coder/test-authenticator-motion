class AnimateImage < UIImageView
  def sprites
    [
      UIImage.imageNamed("images/sprites/s1.png"),
      UIImage.imageNamed("images/sprites/s2.png"),
      UIImage.imageNamed("images/sprites/s3.png"),
      UIImage.imageNamed("images/sprites/s4.png"),
      UIImage.imageNamed("images/sprites/s5.png"),
      UIImage.imageNamed("images/sprites/s6.png"),
      UIImage.imageNamed("images/sprites/s7.png"),
      UIImage.imageNamed("images/sprites/s8.png"),
      UIImage.imageNamed("images/sprites/s9.png"),
      UIImage.imageNamed("images/sprites/s10.png"),
      UIImage.imageNamed("images/sprites/s11.png"),
      UIImage.imageNamed("images/sprites/s12.png"),
      UIImage.imageNamed("images/sprites/s13.png"),
      UIImage.imageNamed("images/sprites/s14.png"),
      UIImage.imageNamed("images/sprites/s15.png"),
      UIImage.imageNamed("images/sprites/s16.png"),
      UIImage.imageNamed("images/sprites/s17.png")
    ]
  end

  def set_animation
    self.animationImages = sprites
    self.animationDuration = 1
    self.animationRepeatCount = -1
  end

  def self.create
    animated_image = alloc.initWithFrame([position,size_image]);
    animated_image.set_animation
    animated_image.startAnimating
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
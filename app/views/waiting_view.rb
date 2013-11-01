class WaitingView < UIView
  def self.create
    @background = WaitingView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @background.set_background_color
    @background.set_icon_waiting 
    @background
  end

  def set_icon_waiting
    @icon = AnimateImage.create
    @icon.startAnimating
    self.addSubview(@icon)
  end

  def set_background_color
    self.backgroundColor = default_background_color
  end

  def default_background_color
    UIColor.colorWithWhite(0,alpha: 0.6)
  end

  def default_name_image_waiting
    'images/waiting.gif'
  end

  def size_image
    [width_image,height_image]
  end

  def width_image
    128
  end

  def height_image
    128
  end

  private

  def position
    array = UIScreen.mainScreen.bounds.to_a
    array[1][0] = array[1][0] - width_image
    array[1][1] = array[1][1] - height_image
    array[1].map{|i| i / 2 }
  end
end
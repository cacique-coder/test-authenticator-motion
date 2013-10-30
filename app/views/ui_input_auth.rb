class UIInputAuth < UITextField

  def self.create(position)
    UIInputAuth.alloc.initWithFrame([ position,size ])
  end

  def self.create(position, secure: secure)
    field = alloc.initWithFrame([ position,size ])
    field.secureTextEntry = secure
    field
  end

  def initWithFrame(frame)
    super
    self.borderStyle = UITextBorderStyleRoundedRect
    self
  end

  private
  def self.size
    [150,30]
  end
end
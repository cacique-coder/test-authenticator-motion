class UIButtonGray < UIButton
 def self.create(position,text: text)
    button = buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(text,forState:UIControlStateNormal)
    button.frame = CGRectMake(position[0],position[1],size[0],size[1])
    button
  end

  private
  def self.size
    [200,30]
  end
end
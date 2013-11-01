module DelegatedTextFieldsAnimatedOnEdit 
  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
    true
  end

  def textFieldDidBeginEditing(textField)
    self.animateTextField(textField, up: true)
  end


  def textFieldDidEndEditing(textField)     
    self.animateTextField(textField, up: false)
  end

  def animateTextField(textField, up:  up)
    puts "ANIMATE"
    movementDistance = 150
    movementDuration = 0.5
    movement = (up ? -movementDistance : movementDistance);
    
    UIView.beginAnimations("anim", context: nil)
    UIView.setAnimationBeginsFromCurrentState(true)
    UIView.setAnimationDuration(movementDuration)
    self.view.frame = CGRectOffset(self.view.frame, 0, movement)
    UIView.commitAnimations
  end
  
  def green_bar
    self.view.subviews.select{|v| v.stylename == :green_bar}.last
  end  

  def  textViewShouldEndEditing(textView)
    puts "textFieldDidEndEditing"

    true
  end

end
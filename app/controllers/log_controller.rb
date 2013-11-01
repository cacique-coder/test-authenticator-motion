class LogController < UIViewController
  include Auth

  def viewDidLoad
    super
    view.backgroundColor = UIColor.colorWithWhite(1,alpha: 1)
    view.name = "hola"
    form
  end

  def form
    @email = UIInputAuth.create([50,50])
    @password = UIInputAuth.create([50,100],secure: true)
    @submit_login = UIButtonGray.create([50,150],text:"Login with Email")
    @submit_register = UIButtonGray.create([50,200],text:"Login with Email")
    @facebook = UIButtonGray.create([50,250],text:"Submit With Facebook")
    
    @submit_login.addTarget(self,action: :login_action,forControlEvents: UIControlEventTouchUpInside)
    
    view.addSubview(@submit_register)
    view.addSubview(@submit_login)
    view.addSubview(@facebook)
    view.addSubview(@email)
    view.addSubview(@password)
  end

  ######
  # Need define methods for get email and password methods
  ######
  def email_field ; @email ; end
  
  def password_field ; @password ;end

  ####
  #  Wating actions
  ####
  def waiting_view
    @background = WaitingView.create
    view.addSubview(@background)
  end

  def hide_waiting_view
    @background.removeFromSuperview
  end


  #### 
  # Others methods
  ####
  def touchesBegan(touches,withEvent: event) 
    self.view.endEditing(true)
  end

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



end
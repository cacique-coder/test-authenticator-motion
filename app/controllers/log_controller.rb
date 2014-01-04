class LogController < UIViewController
  include Authmotion::EmailLogin
  include Auth::FacebookManager

  def viewDidLoad
    super
    view.backgroundColor = UIColor.colorWithWhite(1,alpha: 1)
    form
  end

  def form
    @email = UIInputAuth.create([50,50])
    @password = UIInputAuth.create([50,100],secure: true)
    
    @submit_login = UIButtonGray.create([50,150],text:"Login with Email")
    @submit_register = UIButtonGray.create([50,200],text:"Register with Email")
    @facebook = UIButtonGray.create([50,250],text:"Submit With Facebook")
    
    @submit_login.addTarget(self,action: :login_action,forControlEvents: UIControlEventTouchUpInside)
    @submit_register.addTarget(self,action: :register_action,forControlEvents: UIControlEventTouchUpInside)
    @facebook.addTarget(self,action: :login_with_facebook,forControlEvents: UIControlEventTouchUpInside)
        
    view.addSubview(@submit_register)
    view.addSubview(@submit_login)
    view.addSubview(@facebook)
    view.addSubview(@email)
    view.addSubview(@password)
  end

  #########
  #  format data for send to server
  #########
  def data_login_user
    {user:{login: @email.text, password:@password.text}}
  end
  def data_register_user
    {user:{login: @email.text, password:@password.text, password_confirmation: @password.text }}
  end

  def facebook_user_data(data)
    App.alert('Get data, Data from facebook')
    puts " facebook data user #{data}"
    hide_waiting_view
  end
  #####
  ## URL connection for login
  ######
  def url_log_in
    "http://auth-motion-server.herokuapp.com/users/login"
  end
  def url_register
    "http://auth-motion-server.herokuapp.com/users"
  end

  ######
  # Need define methods for get email and password methods
  ######
  def user_field ; @email ; end

  def password_field ; @password ;end

  def password_confirmation_field ; @password ;end

  ####
  #  Wating actions
  ####
  def waiting_view
#    @background = WaitingView.create
#    view.addSubview(@background)
  end

  def hide_waiting_view
 #   @background.removefromsuperview
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
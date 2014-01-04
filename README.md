test-authenticator-motion
=========================

this is a aplication for test authentication modules. 

##How use it for login?

 ```ruby
class LoginController < UIViewController
  include Auth::EmailLogin
  
  def viewDidLoad
     #anything here... should be your form
  end

  ## You need define how get this fields, in this example i guess that the
  ## inputs should be @email and @password  
  def user_field
    @email 
  end

  def password_field
    @password
  end

  #  format data for send to server
  def data_login_user
    {user:{login: @email.text, password:@password.text}}
  end

  # URL connection for login
  def url_log_in
    "http://auth-motion-server.herokuapp.com/users/login"
  end

  #  Wating actions. In this app you'll see a background and an animation
  def waiting_view
    @background = WaitingView.create
    view.addSubview(@background)
  end

  def hide_waiting_view
    @background.removeFromSuperview
  end
  
  def success_conection_login
    lambda{ |response| "PUTS YOUR ACTIONS HERE" }
  end
end
 ```

case test
  * {user: login, password: 123456}
  
##How use it for Register?

 ```ruby
class LoginController < UIViewController
  include Auth::EmailLogin
  
  def viewDidLoad
     #anything here... should be your form
  end

  ## You need define how get this fields,
  ## in this example i guess that the inputs should be @email, @password,@password_confirmation  
  def user_field
    @email 
  end

  def password_field
    @password
  end
  
  def password_confirmation_field
    @password_confirmation
  end

  #########
  #  format data for send to server

  def data_login_user
    {user:{login: @email.text, password:@password.text, password_confirmation: @password_confirmation.text}}
  end

  # URL connection for register, POST

  def url_log_in
    "http://auth-motion-server.herokuapp.com/users"
  end

  #  Wating actions. In this app you'll see a background and an animation
  def waiting_view
    @background = WaitingView.create
    view.addSubview(@background)
  end

  def hide_waiting_view
    @background.removeFromSuperview
  end
  
  def success_conection_register
    lambda{ |response| "PUTS YOUR ACTIONS HERE" }
  end
end
 ```

#### case test
  * Can register => {user: login, password: 123456, password_password: 123456}
  * Is registered => {user: registered, password: ..., password: ...} any password it's ok
  * Other error, you can test with any user.
  

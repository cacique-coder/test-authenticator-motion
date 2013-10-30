module Auth
  #method that should be call it for register a user
  def register_action
    if has_enough_data?
      url = ApiUrl.new.register_url
      conection(url,data_login_user)
    else
      App.alert("All fields are required")
      after_conection
    end
  end
  #method that should be call it for log in a user
  def login_action
    if has_enough_data?
      url = ApiUrl.new.login_url
      conection(url,data_login_user)
    else
      App.alert("All fields are required")
      after_conection
    end
  end

  def data_login_user
    raise "data_login_user MUST BE IMPLEMENTED"
  end
  
  def data_create_user
    raise "data_create_user MUST BE IMPLEMENTED"
  end
  
  def has_enough_data?
    raise "has_enough_data? should be implemented"
    @email_field.text != "" && @password_field.text != ""
  end


  def register_facebook_action(data)
    register_facebook_user(facebook_new_user_data(data))
  end  


  def login_or_register_facebook_action(data)
    url = ApiUrl.new.login_facebook
    before_conection
    action = lambda do
      runLoop = NSRunLoop.currentRunLoop    
        BW::HTTP.post(url, {payload: data} ) do |response|
          if response.ok?
            json = parse(response)
          else 
            response.status_code == 422 ? errors_model(response) : other_error
          end
          after_conection
        end
        runLoop.run
    end
    thread = NSThread.alloc.initWithTarget action, selector:"call", object:nil
    thread.start
  end  
  
  def login_facebook_action(data)
    login_user(data_login_facebook_user(data))
  end
  
  def errors_model(response)
    message = parse(response)
    messages=""
    message["errors"].each do |field,message|
      messages = "#{field}: #{message.join("\n")}"
    end
    App.alert(messages)

  end
  
  def before_conection ; end

  def after_conection ; end

  def other_error
    App.alert("Unknow error")
  end

  private 

  def conection(url)
    before_conection
    action = lambda do
      runLoop = NSRunLoop.currentRunLoop    
        BW::HTTP.post(url, {payload: data} ) do |response|
          if response.ok?
            json = parse(response)
            success = true
          else 
            response.status_code == 422 ? errors_model(response) : other_error
          end
          success if success
        end
        runLoop.run
    end
    thread = NSThread.alloc.initWithTarget action, selector:"call", object:nil
    thread.start
  end  

  def parse response
    BW::JSON.parse(response.body)
  end


end

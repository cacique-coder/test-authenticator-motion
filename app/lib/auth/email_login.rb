module Auth
  module EmailLogin
    #method that should be call it for register a user
    def register_action
      waiting_view
      if has_enough_data_register?
        url = ApiUrl.new.register_url
        conection(url,data_login_user)
      else
        App.alert("All fields are required")
        after_conection
      end
      hide_waiting_view
    end

    #method that should be call it for log in a user
    def login_action
      waiting_view
      if has_enough_data_login?
        url = ApiUrl.new.login_url
        conection(url,data_login_user)
      else
        App.alert("All fields are required")
        after_conection
      end
      hide_waiting_view
    end

    def has_enough_data_login?
      if user_field.nil? or password_field.nil?
        raise "You need define email and password field"
      end
      user_field.text != "" && password_field.text != ""
    end


    def has_enough_data?
      if user_field.nil? or password_field.nil? or password_confirmation_field.nil? 
        raise "You need define email, password and password confirmation field"
      end
      user_field.text != "" && password_field.text != ""
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

    def user_field
      raise "should be implemented"
    end

    def login_field
      raise "should be implemented"
    end
    def password_field
      raise "should be implemented"
    end
    def password_confirmation_field
      raise "should be implemented"
    end

    def data_login_user
      raise "data_login_user MUST BE IMPLEMENTED"
    end
    
    def data_create_user
      raise "data_create_user MUST BE IMPLEMENTED"
    end
    
    def errors
      raise "errors should be implemented"
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

    def waiting_view
      raise "waiting_view should be implemented"
    end

    def parse response
      BW::JSON.parse(response.body)
    end 
  end
end

module Auth
  module EmailLogin
    #method that should be call it for register a user
    def register_action
      waiting_view
      if has_enough_data_register?
        conection(url_register,data_register_user)
      else
        App.alert("All fields are required")
      end
      hide_waiting_view
    end

    #method that should be call it for log in a user
    def login_action
      waiting_view
      if has_enough_data_login?
        conection(url_log_in,data_login_user)
      else
        App.alert("All fields are required")
      end
      hide_waiting_view
    end

    def has_enough_data_login?
      if user_field.nil? or password_field.nil?
        raise "You need define email and password field"
      end
      user_valid? and password_field_simple?
    end


    def has_enough_data?
      if user_field.nil? or password_field.nil? or password_confirmation_field.nil? 
        raise "You need define email, password and password confirmation field"
      end
      user_valid? and password_register_valid?
    end


    def errors_model(response)
      message = parse(response)
      messages=""
      message["errors"].each do |field,message|
        messages = "#{field}: #{message.join("\n")}"
      end
      App.alert(messages)
    end

    def user_valid?
      user_field.text != ""
    end

    def password_field_simple?
      password_field.text != ""
    end

    def password_register_valid?
      password_field.text != "" and password_confirmation_field.text == password_field.text
    end
    
    def after_conection ; end

    def other_error
      App.alert("Unknow error")
    end

    ####
    #   This methods should be implemented like a getters. example:
    #   def user_field
    #     @field #should be UITextField
    #   end
    ###


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

    ###########################
    ## Methods for conections
    ###########################

    def url_log_in
      raise 'should be implemented'
    end

    def url_register
      raise 'should be implemented'
    end


    def waiting_view
      raise "waiting_view should be implemented"
    end

    ##############
    #
    # failed conection, should be a lambda
    #
    ###
    def failed_conection(response)
      raise "should be implemented like a lambda"
    end

    private 

    def conection(url,data)
      BW::HTTP.post(url, {payload: data} ) do |response|
        if response.ok?
          json = parse(response)
          success? = true
        else 
          failed_conection.call(response)
        end
        json if success?
      end
    end

    def parse response
      BW::JSON.parse(response.body)
    end 
  end
end

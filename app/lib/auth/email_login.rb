module Auth
  module EmailLogin
    #method that should be call it for register a user
    def register_action
      @action = "Register"
      waiting_view
      if has_enough_data_register?
        response = conection(url_register,data_register_user)
      else
        custom_message("All fields are required")
        hide_waiting_view
      end

    end

    #method that should be call it for log in a user

    def login_action
      @action = "login"
      waiting_view
      if has_enough_data_login?
        response = conection(url_log_in,data_login_user)
      else
        custom_message("All fields are required")
        hide_waiting_view
      end
    end

    def has_enough_data_login?
      if user_field.nil? or password_field.nil?
        raise "You need define email and password field"
      end
      user_valid? and password_field_simple?
    end

    def has_enough_data_register?
      if user_field.nil? or password_field.nil? or password_confirmation_field.nil? 
        raise "You need define email, password and password confirmation field"
      end
      user_valid? and password_register_valid?
    end


    def errors_model(response)
      message_json = parse(response)
      messages=""
      message_json["errors"].each do |field,message_array|
        messages = " #{messages}\n #{field}: #{message_array.join("\n")}"
      end
      custom_message(messages)
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
      custom_message("Unknow error")
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

    ###
    #   This method is a hash, how we send the data
    #  {login: 'x', password: ''}
    ##
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
    # failed conection, should be a lambda
    ###
    def failed_conection
      lambda do |response|
        if response.status_code.to_s =~ /40\d/
          message = "#{@action} failed"
        else
          message = response.error_message
        end
        custom_message(message)
      end 
    end

    def success_conection_register
      lambda{|response| custom_message('Good, user register. May be you need change this :-) ')}      
    end

    def success_conection_login
     lambda{|response| custom_message('Good, user login. May be you need change this :-) ')}
    end

    private 

    def conection(url,data)
      @json = nil
      BW::HTTP.post(url, {payload: data} ) do |response|
        if response.ok?
          @json = parse(response)
          success_conection_register.call(response)
        else 
          failed_conection.call(response)
          @json = nil
        end
        hide_waiting_view
      end
    end

    def custom_message(string)
      App.alert(string)
    end

    def parse response
      puts response.body.class
      BW::JSON.parse(response.body)
    end 
  end
end

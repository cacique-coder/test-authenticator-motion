module Auth
  module FacebookManager
    def login_with_facebook
      auth
      return no_facebook_set_error unless $facebook_set
      timer = EM.add_periodic_timer 1.0 do
        if $renewed    
          @action = 'login'
          before_login_facebook
          EM.cancel_timer(timer) if $renewed
        end
      end        
    end
    
    def register_with_facebook
      auth    
      return no_facebook_set_error unless $facebook_set
      timer = EM.add_periodic_timer 1.0 do
        if $renewed
          @action = 'register'
          before_register_facebook
          EM.cancel_timer(timer) if $renewed
        end
      end
    end  
    
    def auth
      accountStore.requestAccessToAccountsWithType(facebookAccountType,options:options,completion: lambda { |granted,error|
        if (granted)
          accounts = accountStore.accountsWithAccountType(facebookAccountType)
          @facebookAccount = accounts.lastObject
            
          me_info if is_facebook_configured?
          $facebook_set = true
        else
          puts error.localizedDescription
          return false
        end
      })
    end  
    
    def me_info

      access_token = @facebookAccount.credential.oauthToken
      
      meurl = NSURL.URLWithString("https://graph.facebook.com/me")
      merequest = SLRequest.requestForServiceType(SLServiceTypeFacebook, requestMethod:SLRequestMethodGET, URL:meurl, parameters:nil)
      merequest.account = @facebookAccount
   
      merequest.performRequestWithHandler( lambda { |responseData,urlResponse,error| 
        unless error
          response = NSString.alloc.initWithData(responseData,encoding:NSUTF8StringEncoding)
          jsonData = response.dataUsingEncoding(NSUTF8StringEncoding)

          @dict = NSJSONSerialization.JSONObjectWithData(jsonData,options:0,error:nil)
               
          login_or_regist_user  
          
        else
          App.alert("Error!!")   
        end
      })
    end  
    
    def login_or_regist_user
      data = @dict
      login_or_register_facebook_action(facebook_new_user_data(data))
    end  
    
    #####
    # all this data is from user
    ###
    def facebook_new_user_data(data)
      raise "SHOULD BE IMPLEMENT NEW USER DATA"
    end
    
    def is_facebook_configured?
      if !@facebookAccount
        App.alert("Facebook is not configured on this phone. Enable it by going to your phone's settings")
        false
      else
        true  
      end    
    end  

    private

    def accountStore
      ACAccountStore.alloc.init
    end

    def facebookAccountType
      accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
    end

    def options
        { 
            "ACFacebookAppIdKey" => "492234074208492", 
            "ACFacebookPermissionsKey" => ["email"], 
            "ACFacebookAudienceKey" => "ACFacebookAudienceFriends" 
        }
    end
    
    def no_facebook_set_error
      App.alert("You must configure your facebook account on your device settings.")   
    end  
    
  end
end
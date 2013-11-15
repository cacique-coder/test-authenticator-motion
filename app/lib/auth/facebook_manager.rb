module Auth
  module FacebookManager
    def login_with_facebook
      @action = 'login'
      waiting_view
      auth
      unless $facebook_set
        hide_waiting_view
        no_facebook_set_error
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
          $facebook_set = true
          accounts = accountStore.accountsWithAccountType(facebookAccountType)
          @facebookAccount = accounts.lastObject
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
        if error
          custom_message("Error!!")
        else
          me_info_actions(responseData)
        end
      })
    end  

    def me_info_actions(data)
      response = NSString.alloc.initWithData(data,encoding:NSUTF8StringEncoding)
      jsonData = response.dataUsingEncoding(NSUTF8StringEncoding)
      @dict = NSJSONSerialization.JSONObjectWithData(jsonData,options:0,error:nil)
      login_or_regist_user      
    end
    
    def login_or_regist_user
      facebook_user_data(@dict)
    end  
    
    #####
    # all this data is from user
    ###
    def facebook_user_data(data)
      raise "SHOULD BE IMPLEMENT NEW USER DATA"
    end
    
    def is_facebook_configured?
      if !@facebookAccount
        custom_message("Facebook is not configured on this phone. Enable it by going to your phone's settings")
        false
      else
        true
      end    
    end  

    private

    def accountStore
      @account_store ||= ACAccountStore.alloc.init
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
      custom_message("You must configure your facebook account on your device settings.")   
    end

    def custom_message(string)
      App.alert(string)
    end  
    
  end
end
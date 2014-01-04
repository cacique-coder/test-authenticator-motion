module Auth
  module FacebookAppDeletegate
    
    def accountStore
      @account_store ||= ACAccountStore.alloc.init
    end
    
    def facebookAccount
      accounts = accountStore.accountsWithAccountType(facebookAccountType)
      accounts.lastObject unless accounts.nil?
    end
      
    def facebookAccountType
      accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierFacebook)
    end

    def applicationDidBecomeActive(application)
      puts "ALGO PASO"
      $facebook_set = !facebookAccount.nil?
      $renewed = false
      unless facebookAccount.nil?
        accountStore.renewCredentialsForAccount(facebookAccount, completion:  lambda { |renewResult, error| 
          case renewResult
            when ACAccountCredentialRenewResultRenewed
              puts "Renewed"
              $renewed = true
            when ACAccountCredentialRenewResultFailed  
              puts "Renewed Failed"
            when ACAccountCredentialRenewResultRejected
              puts "Renewed Rejected"
            else
              puts  "Oops!!"
            end    
        })
      end       
    end
  end
end
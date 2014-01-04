class User
  attr_accessor :email, :id

  def log_in(params) ;  end


  def self.current_user
    Dispatch.once { @current_user ||= new }
    @current_user
  end

end
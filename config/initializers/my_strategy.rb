Warden::Strategies.add(:my_strategy) do 
  def valid? 
    true
  end 

  def authenticate! 
    u = User.find_for_authentication(:email => params[:email])
    if u.nil? || !u.valid_password?(params[:password])
      fail(:invalid)
    elsif !u.confirmed?
      fail!("Account needs confirmation.")
      redirect!(welcome_path)
    end
  else
    success!(u)
  end    
end
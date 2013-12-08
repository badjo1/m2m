module SessionsHelper
  def sign_in(user)
    remember_token = Party.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, Party.encrypt(remember_token))
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = Party.encrypt(cookies[:remember_token])
    @current_user ||= Party.find_by(remember_token: remember_token)
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
end

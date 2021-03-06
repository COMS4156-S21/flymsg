module SessionsHelper
    def log_in(user)
      session[:user_id] = user.user_id
      session[:first_name] = user.first_name
    end
  
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(user_id: session[:user_id])
      end
    end
  
    def logged_in?
      val = (!current_user.nil?) || (session.has_key? "user_id")
      # puts "Testting for login, result: #{val}, session keys: #{session.keys} and session value: #{session.values}"
      val
    end
  
    def log_out
      session.delete(:user_id)
      session.delete(:first_name)
      @current_user = nil
    end
  
    def current_user?(user)
      user == current_user
    end
  
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end
  
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
  end
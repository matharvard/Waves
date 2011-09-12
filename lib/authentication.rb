module Authentication

  def self.included(controller)
    controller.send(:include, InstanceMethods)
    controller.extend(ClassMethods)
  end

  module ClassMethods
    def self.extended(controller)
      controller.helper_method :current_user, :signed_in?, :signed_out?
      controller.hide_action   :current_user, :current_user=,
                               :signed_in?,   :signed_out?,
                               :sign_in,      :sign_out,
                               :authenticate, :deny_access

    end
  end

  module InstanceMethods

    def current_user
      @_current_user ||= user_from_cookie
    end

    def current_user=(user)
      @_current_user = user
    end

    def signed_in?
      ! current_user.nil?
    end

    def signed_out?
      current_user.nil?
    end

    def authenticate
      deny_access unless signed_in?
    end

    def sign_in(user)
      if user
        cookies[:remember_token] = {
          :value   => user.remember_token,
          :expires => 1.year.from_now.utc
        }
        
        self.current_user = user
      end
    end

    def sign_out
      current_user.reset_remember_token! if current_user
      cookies.delete(:remember_token)
      self.current_user = nil
    end

    def deny_access(flash_message = nil)
      store_location
      redirect_to(sign_in_url, :alert => flash_message)
    end

    protected

    def user_from_cookie
      if token = cookies[:remember_token]
        User.find_by_remember_token(token)
      end
    end

    def store_location
      if request.get?
        session[:return_to] = request.fullpath
      end
    end

    def redirect_back_or(default)
      redirect_to(return_to || default)
      clear_return_to
    end

    def return_to
      session[:return_to] || params[:return_to]
    end

    def clear_return_to
      session[:return_to] = nil
    end
  end

end
class UsersController < ApplicationController
    # def index
    #     @user = session[:userinfo]
    # end
    before_action :require_login

    def index
      @user = current_user
    end

    private

    def require_login
      redirect_to login_path unless current_user
    end
end

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def hello
    render html: "hello, world!"
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end

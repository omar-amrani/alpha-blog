class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] #return current user if doesn't exist hit the db
  end
  def logged_in?
    !!current_user #convert to boolean
  end
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    Rails.logger.info "This is a 404 issue"
    respond_to do |format|
      format.html do
        render file: 'public/404.html', status: :not_found, layout: false
      end
      format.json do
        render status: 404, json: {
            message: "Resource not found"
        }
      end
    end
  end
end


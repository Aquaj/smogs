class ApplicationController < ActionController::Base
  class NotAuthenticatedError < StandardError; end
  LOGIN_KEY = :logged_in

  rescue_from NotAuthenticatedError do
    respond_to do |format|
      format.json { render json: { errors: [message: "401 Not Authorized"] }, status: 401 }
      format.html do
        alert "Not Authorized to access this page, please log in"
        redirect_to new_session_path, redirect: request.original_url
      end
      format.any { head 401 }
    end
  end

  private

    def authenticate!
      authenticated? || raise(NotAuthenticatedError)
    end

    def authenticated?
      session[LOGIN_KEY]
    end
end

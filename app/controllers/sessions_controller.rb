class SessionsController < ApplicationController
  PASSWORD = Rails.application.credentials.admin_password

  def new
    @redirect_to = params[:redirect]
  end

  def create
    if fetch_password == PASSWORD
      session[LOGIN_KEY] = true
      redirect_to params.fetch(:redirect, root_path)
    else
      alert "Wrong, bucko."
      redirect_to new_session_path
    end
  end

  private

    def fetch_password
      params.fetch(:session, {})[:password]
    end
end

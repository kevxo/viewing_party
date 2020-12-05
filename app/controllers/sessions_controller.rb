class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      flash[:error] = 'Credentials are incorrect'
      redirect_to '/'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'You are now logged out'
    redirect_to '/'
  end
end

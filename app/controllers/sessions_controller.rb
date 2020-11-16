class SessionsController < ApplicationController
  def new
    # debugger
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = 'Invalid email/password combination' # 不完全正确
      render 'new'
    end
  end
  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        msg = "Account not activated."
        msg += "Check your email for the activation link."
        flash[:warning] = msg
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Incorrect email or password.'
      render 'new'
    end
  end

  def destroy
   log_out if logged_in?
   redirect_to root_url
  end

end

class SessionsController < ApplicationController

  skip_before_filter :authenticate
  protect_from_forgery :except => :create

  def new
    # render new.html.erb
  end

  def create
    @user = User.authenticate(params[:session][:email], params[:session][:password])
    
    if @user.nil?
      flash[:alert] = "Bad email or password."
      render :new, :status => :unauthorized
    else
      sign_in(@user)
      flash[:notice] = "Signed in."
      redirect_back_or(root_path)
    end
  end

  def destroy
    sign_out
    redirect_to(root_path, :notice => "Signed out.")
  end

end

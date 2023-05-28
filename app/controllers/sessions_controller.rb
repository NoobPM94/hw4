class SessionsController < ApplicationController
  def new
  end

  def create
    
    @user = User.find_by({"email" => params["email"]})
    if @user
      password_the_user_typed = params["password"]
      password_in_the_database = @user["password"]
      if BCrypt::Password.new(password_in_the_database) == password_the_user_typed
        flash["notice"] = "Welcome"
        session["user_id"] = @user["id"]
        redirect_to "/places"
      else
        flash["notice"] = "Our records indicate that you provided a wrong password"
        redirect_to "/sessions/new"
      end
    else
      flash["notice"] = "We cannot find this email id in our records"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    flash["notice"] = "Goodbye!"
    session["user_id"] = nil
    session["user_name"] = nil
    redirect_to "/sessions/new"
  end
end
  
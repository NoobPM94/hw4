class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        redirect_to "/places"
      else
        flash["notice"] = "You have entered the wrong password"
        redirect_to "/login"
      end
    else
      flash["notice"] = "You have entered the wrong e-mail Id"
      redirect_to "/login"
    end
  end

  def destroy
    flash["notice"] = "Goodbye!"
    session["user_id"] = nil
    redirect_to "/sessions/new"
  end
end
  
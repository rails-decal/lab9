class QuitsController < ApplicationController
  before_filter :verify_same_user

  def new
    @user = User.find params[:user_id]
    @quit = @user.quits.build
  end

  def create
    @user = User.find params[:user_id]
    @quit = @user.quits.build quit_params
    if @quit.save
      flash[:success] = 'Created!'
      redirect_to @quit.user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:user_id]
    @quit = Quit.find params[:id]
  end

  def update
    @quit = Quit.find params[:id]
    if @quit.update quit_params
      flash[:success] = 'Updated!'
      redirect_to @quit.user
    else
      render 'edit'
    end
  end

  private

  def verify_same_user
    user = User.find params[:user_id]
    if current_user != user
      flash[:alert] = "Can't create/edit a quit for another person!"
      redirect_to root_path
    end
  end

  def quit_params
    params.require(:quit).permit(:text)
  end
end

class UsersController <  ApplicationController
  before_filter :auth_required

  def show
    @user = UserDecorator.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :time_zone)
  end
end

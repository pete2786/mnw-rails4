class UsersController <  ApplicationController
  before_filter :auth_required

  def show
    @user = User.find(params[:id])
  end
end

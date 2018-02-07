class TweetsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_user, :check_userself, :only => [:index, :edit, :update, ]

  def index
    @tweets = Tweet.all
    @user = current_user
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
  end

  def like
  end

  def unlike
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :intro, :role, :image, :name)
    end

    def check_userself
      if current_user!=@user
      redirect_to restaurants_path
      flash[:alert] = "您無編輯權限！"
      end
  end

end

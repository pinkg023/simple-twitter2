class TweetsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_user, :check_userself, :only => [:index, :edit, :update, ]

  def index
    @tweets = Tweet.all
    @user = current_user
    @recent_tweets = Tweet.order(created_at: :desc).limit(10)
    @pop_tweets = Tweet.order(created_at: :desc).limit(10)
    @tweet = Tweet.new
    #@users # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
  end

  def create
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    @tweet.likes_count = @tweet.likes_count + 1
    @tweet.save
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    @restaurant.favorites_count = @restaurant.favorites_count + 1
    @restaurant.save
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end


  def unlike
    @tweet = Tweet.find(params[:id])
    likes = Like.where(user: current_user)
    likes.destroy_all
    @tweet.likes_count = @tweet.likes_count - 1
    @tweet.save
    redirect_back(fallback_location: root_path)  # 導回上一頁
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

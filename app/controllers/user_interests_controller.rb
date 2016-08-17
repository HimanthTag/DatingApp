class UserInterestsController < ApplicationController
  before_filter :set_user_interest, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_interests = UserInterest.all
    respond_with(@user_interests)
  end

  def show
    respond_with(@user_interest)
  end

  def new
    @user_interest = UserInterest.new
    respond_with(@user_interest)
  end

  def edit
  end

  def create
    @user_interest = UserInterest.new(params[:user_interest])
    @user_interest.save
    respond_with(@user_interest)
  end

  def update
    @user_interest.update_attributes(params[:user_interest])
    respond_with(@user_interest)
  end

  def destroy
    @user_interest.destroy
    respond_with(@user_interest)
  end

  private
    def set_user_interest
      @user_interest = UserInterest.find(params[:id])
    end
end

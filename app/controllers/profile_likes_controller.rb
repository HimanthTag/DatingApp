class ProfileLikesController < ApplicationController
  before_filter :set_profile_like, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @profile_likes = ProfileLike.all
    respond_with(@profile_likes)
  end

  def show
    respond_with(@profile_like)
  end

  def new
    @profile_like = ProfileLike.new
    respond_with(@profile_like)
  end

  def edit
  end

  def create
    @profile_like = ProfileLike.new(params[:profile_like])
    @profile_like.save
    respond_with(@profile_like)
  end

  def like_profile
    ProfileLike.find_or_create_by_user_id_and_liker_id(params[:user_id],current_user.id)
    render :text => ProfileLike.where(:user_id=>params[:user_id]).length
  end

  def update
    @profile_like.update_attributes(params[:profile_like])
    respond_with(@profile_like)
  end

  def destroy
    @profile_like.destroy
    respond_with(@profile_like)
  end

  private
    def set_profile_like
      @profile_like = ProfileLike.find(params[:id])
    end
end

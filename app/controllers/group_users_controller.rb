class GroupUsersController < ApplicationController
  before_filter :set_group_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @group_users = GroupUser.all
    respond_with(@group_users)
  end

  def show
    respond_with(@group_user)
  end

  def new
    @group_user = GroupUser.new
    respond_with(@group_user)
  end

  def edit
  end

  def create
    @group_user = GroupUser.new(params[:group_user])
    @group_user.save
    respond_with(@group_user)
  end

  def update
    @group_user.update_attributes(params[:group_user])
    respond_with(@group_user)
  end

  def destroy
    @group_user.destroy
    respond_with(@group_user)
  end

  private
    def set_group_user
      @group_user = GroupUser.find(params[:id])
    end
end

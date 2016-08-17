class InterestsController < ApplicationController
  before_filter :set_interest, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @interests = Interest.all
    respond_with(@interests)
  end

  def show
    respond_with(@interest)
  end

  def new
    @interest = Interest.new
    respond_with(@interest)
  end

  def edit
  end

  def create
    @interest = Interest.new(params[:interest])
    @interest.save
    respond_with(@interest)
  end

  def update
    @interest.update_attributes(params[:interest])
    respond_with(@interest)
  end

  def destroy
    @interest.destroy
    respond_with(@interest)
  end

  private
    def set_interest
      @interest = Interest.find(params[:id])
    end
end

class GendersController < ApplicationController
  before_filter :set_gender, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @genders = Gender.all
    respond_with(@genders)
  end

  def show
    respond_with(@gender)
  end

  def new
    @gender = Gender.new
    respond_with(@gender)
  end

  def edit
  end

  def create
    @gender = Gender.new(params[:gender])
    @gender.save
    respond_with(@gender)
  end

  def update
    @gender.update_attributes(params[:gender])
    respond_with(@gender)
  end

  def destroy
    @gender.destroy
    respond_with(@gender)
  end

  private
    def set_gender
      @gender = Gender.find(params[:id])
    end
end

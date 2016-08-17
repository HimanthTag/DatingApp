class EthnicitiesController < ApplicationController
  before_filter :set_ethnicity, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @ethnicities = Ethnicity.all
    respond_with(@ethnicities)
  end

  def show
    respond_with(@ethnicity)
  end

  def new
    @ethnicity = Ethnicity.new
    respond_with(@ethnicity)
  end

  def edit
  end

  def create
    @ethnicity = Ethnicity.new(params[:ethnicity])
    @ethnicity.save
    respond_with(@ethnicity)
  end

  def update
    @ethnicity.update_attributes(params[:ethnicity])
    respond_with(@ethnicity)
  end

  def destroy
    @ethnicity.destroy
    respond_with(@ethnicity)
  end

  private
    def set_ethnicity
      @ethnicity = Ethnicity.find(params[:id])
    end
end

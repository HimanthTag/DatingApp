class RelationshipsController < ApplicationController
  before_filter :set_relationship, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @relationships = Relationship.all
    respond_with(@relationships)
  end

  def show
    respond_with(@relationship)
  end

  def new
    @relationship = Relationship.new
    respond_with(@relationship)
  end

  def edit
  end

  def create
    @relationship = Relationship.new(params[:relationship])
    @relationship.save
    respond_with(@relationship)
  end

  def update
    @relationship.update_attributes(params[:relationship])
    respond_with(@relationship)
  end

  def destroy
    @relationship.destroy
    respond_with(@relationship)
  end

  private
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end
end

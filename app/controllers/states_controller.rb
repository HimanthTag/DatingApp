class StatesController < ApplicationController
  before_filter :set_state, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @states = State.all
    respond_with(@states)
  end

  def show
    respond_with(@state)
  end

  def new
    @state = State.new
    respond_with(@state)
  end

  def edit
  end

  def create
    @state = State.new(params[:state])
    @state.save
    respond_with(@state)
  end

  def update
    @state.update_attributes(params[:state])
    respond_with(@state)
  end

  def destroy
    @state.destroy
    respond_with(@state)
  end

  private
    def set_state
      @state = State.find(params[:id])
    end
end

class PokemongoTeamsController < ApplicationController
  before_filter :set_pokemongo_team, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pokemongo_teams = PokemongoTeam.all
    respond_with(@pokemongo_teams)
  end

  def show
    respond_with(@pokemongo_team)
  end

  def new
    @pokemongo_team = PokemongoTeam.new
    respond_with(@pokemongo_team)
  end

  def edit
  end

  def create
    @pokemongo_team = PokemongoTeam.new(params[:pokemongo_team])
    @pokemongo_team.save
    respond_with(@pokemongo_team)
  end

  def update
    @pokemongo_team.update_attributes(params[:pokemongo_team])
    respond_with(@pokemongo_team)
  end

  def destroy
    @pokemongo_team.destroy
    respond_with(@pokemongo_team)
  end

  private
    def set_pokemongo_team
      @pokemongo_team = PokemongoTeam.find(params[:id])
    end
end

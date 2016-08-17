class MessagesController < ApplicationController
  before_filter :authenticate_user!
  require 'action_view'
  require 'action_view/helpers'
  include ActionView::Helpers::DateHelper

  def new
  	 @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:notice] = "Message has been sent!"
    redirect_to url_for(:controller => :conversations, :action => :index)
  end
end
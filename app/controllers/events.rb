class EventGroupsController < ApplicationController
  before_filter :authenticate_user!

  layout false

  def create
    if EventGroup.between(params[:sender_id],params[:recipient_id]).present?
      @events = EventGroup.between(params[:sender_id],params[:recipient_id]).first
    else
      @events = EventGroup.create!(eventgroup_params)
    end

    render json: { eventgroup_id: @eventgroup.id }
  end

  def show
    @eventgroup = EventGroup.find(params[:id])
    @reciever = interlocutor(@eventgroup)
    @events = @events.event
    @event = Event.new
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(eventgroup)
    current_user == eventgroup.recipient ? eventgroup.sender : eventgroup.recipient
  end
end

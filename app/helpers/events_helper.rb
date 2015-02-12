module EventsHelper
  def self_or_other(event)
    event.user == current_user ? "self" : "other"
  end

  def event_interlocutor(message)
    event.user == event.conversation.sender ? event.conversation.sender : event.conversation.recipient
  end
end

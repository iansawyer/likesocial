class EventGroup < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :events, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :involving, -> (user) do
    where("eventgroups.sender_id =? OR eventgroups.recipient_id =?",user.id,user.id)
  end

  scope :between, -> (sender_id,recipient_id) do
    where("(eventgroups.sender_id = ? AND eventgroups.recipient_id =?) OR (eventgroups.sender_id = ? AND eventgroups.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end
end
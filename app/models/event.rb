class Event < ActiveRecord::Base
  belongs_to :eventgroup
  belongs_to :user

  validates_presence_of :body, :eventgroup_id, :user_id
end

class Vote
  include Mongoid::Document
  field :up, :type => Boolean
  referenced_in :user
  referenced_in :solution

  validates_presence_of :user_id, :solution_id
  validates_uniqueness_of :user_id, scope: :solution_id

  scope :upvote, where(up: true)
  scope :downvote, where(up: false)
end

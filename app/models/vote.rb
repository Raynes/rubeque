class Vote
  include Mongoid::Document
  field :up, :type => Boolean
  referenced_in :user
  referenced_in :solution

  index [:solution_id, :user_id]

  validates_presence_of :user_id, :solution_id
  validates_uniqueness_of :user_id, scope: :solution_id

  after_save :update_user_score, :update_solution_score
  after_destroy :update_user_score, :update_solution_score

  scope :upvote, where(up: true)
  scope :downvote, where(up: false)

  def integer_value
    self.up? ? 1 : -1
  end

  protected

    def update_user_score
      user.update_score
    end

    def update_solution_score
      solution.update_score
    end
end

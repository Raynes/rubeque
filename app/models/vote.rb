class Vote
  include Mongoid::Document
  field :up, :type => Boolean
  referenced_in :user
  referenced_in :solution

  validates_presence_of :user_id, :solution_id
  validates_uniqueness_of :user_id, scope: :solution_id
  
  after_save :update_user_score

  scope :upvote, where(up: true)
  scope :downvote, where(up: false)
  
  
  def integer_value
    self.up? ? 1 : -1
  end
  
  protected
    
    def update_user_score
      if self.new_record? || self.up_changed?
        solution_user = self.solution.try(:user)
        if solution_user
          solution_user.score ||= 0
          solution_user.score = solution_user.score + self.integer_value
          solution_user.save
        end
      end
    end
end

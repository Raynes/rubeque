class Problem
  include Mongoid::Document
  include Mongoid::Timestamps
  scope :approved, proc{ where(approved: true )}
  scope :unapproved, proc{ any_of({approved: nil}, {approved: false}) }
  field :title
  field :instructions
  field :code
  field :difficulty
  field :approved, type: Boolean
  field :_id, type: Integer
  key :_id

  before_create :check_problem_id

  references_many :solutions

  DIFFICULTY_LEVELS = ["easy", "medium", "hard"]

  validates_presence_of :title, :code, :difficulty
  
  
  def to_s
    "#{title}"
  end

  def solved?(user)
    user.present? && solutions.where(:user_id => user.id).present?
  end

  private

    def check_problem_id
      existing_problem = Problem.find(self._id) rescue nil
      if existing_problem
        errors.add(:base, "There was a problem id collision. Please try again.")
        return false
      end
    end
end

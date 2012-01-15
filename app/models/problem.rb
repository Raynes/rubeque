class Problem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :_id, type: Integer
  key :_id

  field :title
  field :instructions
  field :code
  field :difficulty
  field :approved, type: Boolean

  references_many :solutions
  referenced_in :creator, class_name: "User"

  scope :approved, proc{ where(approved: true ) }
  scope :unapproved, proc{ any_of({approved: nil}, {approved: false}) }

  before_create :automatically_approve

  DIFFICULTY_LEVELS = ["easy", "medium", "hard"]

  validates_presence_of :title, :code, :difficulty
  validates_uniqueness_of :title

  def to_s
    "#{title}"
  end

  def solved?(user)
    user.present? && solutions.where(:user_id => user.id).present?
  end

  def approve
    update_attribute(:approved, true)
  end

  private

    def automatically_approve
      approved = true if creator && creator.admin?
    end
end

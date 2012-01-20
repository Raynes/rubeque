class Problem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :_id, type: Integer
  key :_id

  field :title
  field :instructions
  field :code
  field :difficulty, type: Integer
  field :approved, type: Boolean

  references_many :solutions, dependent: :destroy
  referenced_in :creator, class_name: "User"
  embeds_many :tags

  scope :approved, proc{ where(approved: true ) }
  scope :unapproved, proc{ any_of({approved: nil}, {approved: false}) }

  before_create :automatically_approve

  DIFFICULTY_LEVELS = ["Elementary", "Easy", "Medium", "Hard"]

  validates_presence_of :title, :code, :difficulty
  validates_uniqueness_of :title

  validates_inclusion_of :difficulty, in: (0..3)

  def to_s
    "#{title}"
  end

  def status
    approved? ? "approved" : "unapproved"
  end

  def solved?(user)
    user.present? && solutions.where(:user_id => user.id).present?
  end

  def approve
    update_attribute(:approved, true)
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(tag_list)
    tag_list.split(",").each do |tag|
      unless tags.where(name: tag).any?
        tags.new(name: tag)
      end
    end
  end

  def difficulty_word
    DIFFICULTY_LEVELS[read_attribute(:difficulty).to_i]
  end

  private

    def automatically_approve
      approved = true if creator && creator.admin?
    end
end

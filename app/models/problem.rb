class Problem
  include Mongoid::Document
  field :title
  field :instructions
  field :code
  field :difficulty

  embeds_many :solutions

  DIFFICULTY_LEVELS = ["easy", "medium", "hard"]

  validates_presence_of :title, :code, :difficulty
end

class Problem
  include Mongoid::Document
  field :title, :type => String
  field :instructions, :type => String
  field :code, :type => String
  field :difficulty, :type => String
end

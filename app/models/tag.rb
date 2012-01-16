class Tag
  include Mongoid::Document
  field :name, :type => String
  embedded_in :problem, :inverse_of => :tags
end

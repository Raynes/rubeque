class UserToken
  # holds the provider authentication for users
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String

  referenced_in :user

  validates_uniqueness_of :uid, scope: :provider
end

class UserToken
  # holds the provider authentication for users
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  field :provider, :type => String
  field :uid, :type => String

  referenced_in :user

  validates_uniqueness_of :uid, scope: :provider

  track_history :track_create   => true,
                :track_destroy  => true
end

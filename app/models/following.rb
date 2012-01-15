class Following
  include Mongoid::Document

  referenced_in :user
  referenced_in :follower, class_name: "User"
end

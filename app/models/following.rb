class Following
  include Mongoid::Document

  referenced_in :user
  referenced_in :follower, class_name: "User"

  index [:follower_id, :user_id]
end

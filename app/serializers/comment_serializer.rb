class CommentSerializer < ActiveModel::Serializer
  attributes :id, :note
  has_one :picture
  has_one :user
end

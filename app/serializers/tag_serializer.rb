class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :created_at
end

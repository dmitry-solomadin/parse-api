class PageSerializer < ActiveModel::Serializer
  attributes :id, :url, :created_at

  has_many :tags
end

class Page < ActiveRecord::Base
  has_many :tags, dependent: :destroy

  validates :url, presence: true, uniqueness: true
end

class Tag  < ActiveRecord::Base
  belongs_to :page

  validates :page, :name, presence: true
end

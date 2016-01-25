class Toy < ActiveRecord::Base

  TYPES = [
    "string",
    "yarnball",
    "mouse"
  ]

  validates :cat_id, :name, :model, presence: true
  validates :model, inclusion: TYPES

  belongs_to :cat
end

class Cargo < ApplicationRecord
  belongs_to :workspace
  has_many :categories, class_name: 'CargoCategory', dependent: :destroy

  def first_level_categories
    categories.where(parent_id: nil)
  end
end

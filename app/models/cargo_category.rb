class CargoCategory < ApplicationRecord
  belongs_to :cargo
  belongs_to :parent, class_name: 'CargoCategory', optional: true
  has_many :children, class_name: 'CargoCategory', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :tag, class_name: 'WorkspaceTag', optional: true
end

class Workspace < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :user_workspaces
end

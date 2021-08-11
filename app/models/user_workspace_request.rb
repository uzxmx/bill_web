class UserWorkspaceRequest < ApplicationRecord
  belongs_to :workspace
  belongs_to :user

  enum status: %i[initial allowed rejected]
end

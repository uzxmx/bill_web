class WorkspaceTag < ApplicationRecord
  belongs_to :workspace

  enum tag_type: %i[cargo_category bill]
end

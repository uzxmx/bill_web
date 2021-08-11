class Bill < ApplicationRecord
  belongs_to :workspace
  belongs_to :cargo_category, optional: true

  enum bill_type: %i[income spend]
end

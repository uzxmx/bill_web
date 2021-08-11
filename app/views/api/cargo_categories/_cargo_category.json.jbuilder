# frozen_string_literal: true

json.extract! cargo_category, :id, :name, :photo, :price, :count, :note, :level, :tag_id, :parent_id
if cargo_category.level.nil? || cargo_category.level == 0
  json.children cargo_category.children, partial: 'api/cargo_categories/cargo_category', as: :cargo_category
end

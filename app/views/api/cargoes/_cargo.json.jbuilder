# frozen_string_literal: true

json.extract! cargo, :id, :name, :price, :note, :created_at, :updated_at

json.categories cargo.first_level_categories, partial: 'api/cargo_categories/cargo_category', as: :cargo_category

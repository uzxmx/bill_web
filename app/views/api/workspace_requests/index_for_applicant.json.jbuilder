# frozen_string_literal: true

json.array! @workspace_requests do |r|
  json.extract! r, :id, :created_at, :status
  json.created_at r.created_at.strftime('%Y-%m-%d %H:%M:%S')
  json.workspace do
    json.extract! r.workspace, :id, :name
  end
end

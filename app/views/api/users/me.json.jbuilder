# frozen_string_literal: true

json.extract! current_user, :nickname, :avatar

if current_workspace
  json.current_workspace do
    json.extract! current_workspace, :id, :name
  end
end

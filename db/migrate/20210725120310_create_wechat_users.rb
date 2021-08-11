class CreateWechatUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :wechat_users do |t|
      t.string :open_id
      t.string :nickname
      t.string :avatar_url
      t.integer :gender
      t.string :language
      t.string :country
      t.string :province
      t.string :city
      t.text :raw_data
      t.integer :user_id

      t.timestamps
    end
  end
end

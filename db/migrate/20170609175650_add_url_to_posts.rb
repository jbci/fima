class AddUrlToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :url_link, :string
  end
end

class AddUrlToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :url_link, :string
  end
end

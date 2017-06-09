class AddUrlToEvaluations < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :url_link, :string
  end
end

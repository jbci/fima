class AddEndDate2ToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :end_date_2, :date
  end
end

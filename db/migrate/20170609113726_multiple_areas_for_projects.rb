class MultipleAreasForProjects < ActiveRecord::Migration[5.0]
  def up
    create_table :areas_projects, :id => false do |t|
      t.references :area, :project
    end
    Project.class_eval do
      belongs_to  :old_area,
                  :class_name => "Area",
                  :foreign_key => "area_id"
    end
    Project.all.each do |project|
      unless project.old_area.nil?
        project.areas << project.old_area
        project.save
      end
    end
    remove_column :projects, :area_id
  end

  def down
    add_column :projects, :area_id, :integer
    Project.class_eval do
      belongs_to  :new_area,
                  :class_name => "Area",
                  :foreign_key => "area_id"
    end
    Project.all.each do |project|
      project.new_area = project.areas.first unless project.areas.empty?
      project.save
    end
    drop_table :areas_projects
  end
end

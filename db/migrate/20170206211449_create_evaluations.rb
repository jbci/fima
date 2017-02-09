class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.references :area, foreign_key: true
      t.references :indicator, foreign_key: true
      t.boolean :visible
      t.string :value

      t.timestamps
    end
  end
end

class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :minutes
      t.text :reason
      t.text :from

      t.timestamps null: false
    end
  end
end

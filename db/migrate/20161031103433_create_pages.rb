class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url, null: false, uniq: true

      t.timestamps
    end

    create_table :tags do |t|
      t.integer :page_id, null: false
      t.string :name, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end

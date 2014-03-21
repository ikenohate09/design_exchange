class CreateMethodFavorites < ActiveRecord::Migration
  def change
    create_table :method_favorites do |t|
      t.integer :user_id
      t.integer :design_method_id
      t.timestamps
    end
  end
end

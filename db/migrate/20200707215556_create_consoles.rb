class CreateConsoles < ActiveRecord::Migration
  def change
    create_table :consoles do |c|
      c.string :name
      c.integer :release_year
      c.string :manufacturer
      c.integer :user_id
    end
  end
end

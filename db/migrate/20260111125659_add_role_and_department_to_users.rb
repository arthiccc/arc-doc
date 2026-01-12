class AddRoleAndDepartmentToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer
    add_reference :users, :department, null: true, foreign_key: true
  end
end

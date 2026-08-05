class SetDefaultRoleOnUsers < ActiveRecord::Migration[8.0]
  def up
    User.where(role: nil).update_all(role: "reader")

    change_column_default :users, :role, "reader"
    change_column_null :users, :role, false
  end

  def down
    change_column_null :users, :role, true
    change_column_default :users, :role, nil
  end
end

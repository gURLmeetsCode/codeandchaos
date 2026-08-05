class SetDefaultViewCountOnPosts < ActiveRecord::Migration[8.0]
  def up
    change_column_default :posts, :view_count, from: nil, to: 0
    Post.where(view_count: nil).update_all(view_count: 0)
    change_column_null :posts, :view_count, false
  end

  def down
    change_column_null :posts, :view_count, true
    change_column_default :posts, :view_count, from: 0, to: nil
  end
end

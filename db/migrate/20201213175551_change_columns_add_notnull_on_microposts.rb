class ChangeColumnsAddNotnullOnMicroposts < ActiveRecord::Migration[6.0]
  def change
    change_column_null :microposts, :content, false
  end
end

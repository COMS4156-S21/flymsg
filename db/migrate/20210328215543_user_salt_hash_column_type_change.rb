class UserSaltHashColumnTypeChange < ActiveRecord::Migration[6.1]
  def change
    change_column(:users, :salt, :binary)
    change_column(:users, :hashed_pwd, :binary)
  end

  def up
    change_column(:users, :salt, :binary)
    change_column(:users, :hashed_pwd, :binary)
  end

  def down
    change_column(:users, :salt, :string)
    change_column(:users, :hashed_pwd, :string)
  end
end

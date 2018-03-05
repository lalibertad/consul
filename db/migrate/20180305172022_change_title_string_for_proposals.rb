class ChangeTitleStringForProposals < ActiveRecord::Migration
  def change
    change_column :proposals, :title, :string, :limit => 110
  end
end

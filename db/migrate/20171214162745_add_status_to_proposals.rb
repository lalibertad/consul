class AddStatusToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :status, :boolean, default: false
  end
end

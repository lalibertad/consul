class AddRejectionDescriptionToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :rejection_description, :text
  end
end

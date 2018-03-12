class AddDurationToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :duration, :string
    add_column :proposals, :price_first_year, :decimal, :precision => 12, :scale => 2
  end
end

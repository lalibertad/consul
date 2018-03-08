class AddColumnsToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :snip, :string
    add_column :proposals, :gap_contributes, :string
    add_column :proposals, :strategic_objective, :string
    add_column :proposals, :specific_objective, :string
    add_column :proposals, :problem_solve, :string
    add_column :proposals, :potentiality_solve, :string
    add_column :proposals, :population, :integer
    add_column :proposals, :price, :decimal, :precision => 12, :scale => 2
    add_column :proposals, :executor, :string
    add_column :proposals, :responsable, :string
  end
end

class AddProposalIdToInvestment < ActiveRecord::Migration
  def change
    add_column :budget_investments, :proposal_id, :integer
  end
end

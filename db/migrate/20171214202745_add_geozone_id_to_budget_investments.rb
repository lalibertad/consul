class AddGeozoneIdToBudgetInvestments < ActiveRecord::Migration
  def change
    add_column :budget_investments, :geozone_id, :integer
  end
end

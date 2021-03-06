defmodule Spendable.Repo.Migrations.BudgetAllocations do
  use Ecto.Migration

  def change do
    create table(:budget_allocations) do
      add(:transaction_id, references(:transactions, on_delete: :delete_all), null: false)
      add(:budget_id, references(:budgets, on_delete: :delete_all), null: false)
      add(:amount, :decimal, precision: 17, scale: 2, null: false)
      timestamps()
    end
  end
end

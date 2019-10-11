defmodule Budget.Banks.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bank_transactions" do
    field :amount, :decimal
    field :date, :date
    field :external_id, :string
    field :location, :map
    field :name, :string
    field :pending, :boolean

    belongs_to :category, Budget.Banks.Category
    belongs_to :user, Budget.User
    belongs_to :bank_account, Budget.Banks.Account

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, __schema__(:fields) -- [:id])
    |> validate_required([:user_id, :amount, :date, :external_id, :bank_account_id, :name, :pending])
    |> unique_constraint(:external_id, name: :bank_transactions_bank_account_id_external_id_index)
  end
end

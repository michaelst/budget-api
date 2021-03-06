defmodule Spendable.Budgets.Budget.Resolver do
  import Ecto.Query, only: [from: 2]

  alias Spendable.Budgets.Budget
  alias Spendable.Repo

  def list(_args, %{context: %{current_user: user}}) do
    {:ok, from(Budget, where: [user_id: ^user.id]) |> Repo.all() |> Enum.sort_by(& &1.name)}
  end

  def get(_params, %{context: %{model: model}}) do
    {:ok, model}
  end

  def create(params, %{context: %{current_user: user}}) do
    %Budget{user_id: user.id}
    |> Budget.changeset(params)
    |> Repo.insert()
  end

  def update(params, %{context: %{model: model}}) do
    model
    |> Budget.changeset(params)
    |> Repo.update()
  end

  def delete(_params, %{context: %{model: model}}) do
    Repo.delete(model)
  end
end

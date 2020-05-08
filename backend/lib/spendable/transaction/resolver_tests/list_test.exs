defmodule Spendable.Transaction.Resolver.ListTest do
  use Spendable.Web.ConnCase, async: true
  import Spendable.Factory

  alias Spendable.Banks.Category
  alias Spendable.Repo

  test "list transactions", %{conn: conn} do
    {user, token} = Spendable.TestUtils.create_user()
    category_id = Repo.get_by!(Category, external_id: "22006001").id
    budget = insert(:budget, user: user)

    expense = insert(:transaction, user: user, category_id: category_id, amount: -20.24)
    insert(:allocation, user: user, budget: budget, transaction: expense, amount: -20.24)

    deposit =
      insert(:transaction,
        user: user,
        category_id: category_id,
        amount: 3314.89,
        date: Date.utc_today()
      )

    insert(:allocation, user: user, budget: budget, transaction: deposit, amount: 3314.89)

    query = """
      query {
        transactions {
          id
          name
          note
          amount
          date
          category {
              id
          }
          allocations {
            amount
            budget {
              id
            }
          }
        }
      }
    """

    response =
      conn
      |> put_req_header("authorization", "Bearer #{token}")
      |> post("/graphql", %{query: query})
      |> json_response(200)

    assert %{
             "data" => %{
               "transactions" => [
                 %{
                   "allocations" => [
                     %{
                       "amount" => "#{Decimal.new("3314.89")}",
                       "budget" => %{"id" => "#{budget.id}"}
                     }
                   ],
                   "amount" => "#{deposit.amount}",
                   "category" => %{"id" => "#{category_id}"},
                   "date" => "#{deposit.date}",
                   "id" => "#{deposit.id}",
                   "name" => "test",
                   "note" => "some notes"
                 },
                 %{
                   "allocations" => [
                     %{
                       "amount" => "#{Decimal.new("-20.24")}",
                       "budget" => %{"id" => "#{budget.id}"}
                     }
                   ],
                   "amount" => "#{expense.amount}",
                   "category" => %{"id" => "#{category_id}"},
                   "date" => "#{expense.date}",
                   "id" => "#{expense.id}",
                   "name" => "test",
                   "note" => "some notes"
                 }
               ]
             }
           } == response
  end
end
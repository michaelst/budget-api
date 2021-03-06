defmodule Spendable.Banks.Member.Resolver.CreatePublicTokenTest do
  use Spendable.Web.ConnCase, async: true
  import Tesla.Mock
  import Spendable.Factory

  setup do
    mock(fn
      %{method: :post, url: "https://sandbox.plaid.com/item/public_token/create"} ->
        json(%{
          public_token: "public-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d",
          request_id: "Aim3b"
        })
    end)

    :ok
  end

  test "create public token to fix connection" do
    user = Spendable.TestUtils.create_user()
    member = insert(:bank_member, user: user)

    query = """
    mutation {
      createPublicToken(id: "#{member.id}")
    }
    """

    assert {:ok,
            %{
              data: %{
                "createPublicToken" => "public-sandbox-b0e2c4ee-a763-4df5-bfe9-46a46bce993d"
              }
            }} = Absinthe.run(query, Spendable.Web.Schema, context: %{current_user: user})
  end
end

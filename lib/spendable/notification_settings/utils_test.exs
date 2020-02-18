defmodule Spendable.Notifications.Settings.UtilsTest do
  use Spendable.DataCase, async: true
  import Spendable.Factory

  alias Spendable.Notifications.Settings.Utils

  test "send apns notification" do
    {user, _} = Spendable.TestUtils.create_user()
    insert(:notification_settings, user: user, device_token: "test", enabled: true)

    assert_raise RuntimeError, "device_tokens must be preloaded", fn ->
      Utils.send(user, "title", "body")
    end

    user = Spendable.Repo.preload(user, :device_tokens)
    Utils.send(user, "title", "body")
  end
end
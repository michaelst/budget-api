defmodule Spendable.Web.Router do
  use Spendable.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.Pipeline, module: Spendable.Guardian, error_handler: Spendable.Web.AuthErrorHandler
    plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
    plug(Guardian.Plug.LoadResource, allow_blank: true)
    plug Spendable.Web.Context
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Spendable.Web.Schema
    forward "/graphql", Absinthe.Plug, schema: Spendable.Web.Schema
  end
end
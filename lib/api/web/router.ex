defmodule API.Web.Router do
  use API.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", API.Web do
    pipe_through :api
  end

  forward "/api", Absinthe.Plug,
    schema: API.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: API.Schema
end

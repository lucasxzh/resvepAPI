defmodule ResvepAPIWeb.Router do
  use ResvepAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ResvepAPIWeb do
    pipe_through :api

    resources "/events", EventController, only: [:create, :show]

    post "/events/:event_id/guests", GuestController, :create
  end
end

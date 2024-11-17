defmodule ResvepAPIWeb.EventController do
  use ResvepAPIWeb, :controller

  alias ResvepAPI.{Repo, Event}

  def create(conn, %{"name" => name, "limit" => limit}) do
    event_params = %{
      "name" => name,
      "limit" => limit
    }

    changeset = Event.changeset(%Event{}, event_params)

    case Repo.insert(changeset) do
      {:ok, event} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Event created successfully", event: event})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset.errors})
    end
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get(Event, id) |> Repo.preload(:guests)

    case event do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Event not found"})

      event ->
        conn
        |> put_status(:ok)
        |> json(event)
    end
  end
end

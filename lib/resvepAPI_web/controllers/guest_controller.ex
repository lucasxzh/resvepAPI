defmodule ResvepAPIWeb.GuestController do
  use ResvepAPIWeb, :controller

  alias ResvepAPI.{Repo, Event, Guest}

  def create(conn, %{"event_id" => event_id, "name" => name}) do
    case Repo.get(Event, event_id) |> Repo.preload(:guests) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Event not found"})

      event ->
        if event.limit && length(event.guests) >= event.limit do
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{error: "Event is at full capacity"})
        else
          changeset = Guest.changeset(%Guest{}, %{"name" => name, "event_id" => event.id})

          case Repo.insert(changeset) do
            {:ok, guest} ->
              conn
              |> put_status(:created)
              |> json(%{message: "Guest created successfully", guest: guest})

            {:error, changeset} ->
              conn
              |> put_status(:unprocessable_entity)
              |> json(%{errors: changeset.errors})
          end
        end
    end
  end
end

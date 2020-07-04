defmodule Server.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: true
  alias Server.Repo

  alias Server.Accounts.User

  @doc """
  Send magic link to user
  """
  def create(%Ecto.Changeset{} = user) do
    case Repo.insert(user) do
      {:ok, %User{} = newUser} ->
        IO.puts inspect newUser
        send(newUser)
      {:error, %Ecto.Changeset{} = changeset} ->
        existingUser = Repo.get_by(User, email: changeset.changes.email)
        IO.puts "<> Inspecting User <>"
        IO.puts inspect existingUser
        send(existingUser)
    end
  end

  def change_user() do
    User.changeset(%User, %{})
  end
    
  defp send(%User{} = user) do
    user = Repo.get_by(User,email: user.email)
    user = insert(user, user.email)
    send_link(user)
  end

  defp send(nil) do
  end

  defp insert(nil, email) do
    changeset = User.changeset(%User{}, %{email: email})
    Repo.insert(User, changeset)
  end

  defp insert(user, _) do #No need to insert, user already exists.
    user
  end

  defp send_link(user) do
    IO.puts "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>"
    IO.puts inspect user
  end
end

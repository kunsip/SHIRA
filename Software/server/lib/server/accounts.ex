defmodule Server.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Server.Accounts.MagicLink
  alias Server.Accounts.User
  alias Server.Repo

  @doc """
  Must pass in a user
  """
  def create_magic_link(user \\ %{}) do
    case MagicLink.create_link(user) do
      {:ok, magic_link} ->
        IO.puts IO.inspect magic_link
      {:error, reason} ->
       IO.puts IO.inspect reason
    end
    #We need to generate magic link
    #We need to insert magic link
    #We need to get magic link back

    #We then need to add user to magic link
    #We then need to return magic link in {:ok, "randomstring"}
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  
  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def list_users do
    Repo.all(User)
  end
end

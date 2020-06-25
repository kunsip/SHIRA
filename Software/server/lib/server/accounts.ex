defmodule Server.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Server.Accounts.User
  alias Server.Repo


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

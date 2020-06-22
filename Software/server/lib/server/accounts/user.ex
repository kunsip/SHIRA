defmodule Server.Accounts.User do
  @moduledoc """
  User provides a simple interface that allows us to keep track of the user along with the nessary states on the user account
  """
  # Treat database with same care as we treat our code.
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string

    timestamps()
  end
end

defmodule Server.Accounts.User do
  @moduledoc """
  User provides a simple interface that allows us to keep track of the user along with the nessary states on the user account
  """
  # Treat database with same care as we treat our code.
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    has_many :magic_links, Server.Accounts.MagicLink

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
  end
end

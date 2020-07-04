defmodule Server.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Server.AuthToken

  schema "users" do
    field :email, :string
    has_many :auth_tokens, AuthToken

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint([:email])
  end
end

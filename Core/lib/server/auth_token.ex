defmodule Server.AuthToken do
  @moduledoc '''
  Generates Authentication Token for user. These tokens are unique and are used one time.

  However there exists currently a possiblity that token is NOT unique. See issue #80 [https://gitlab.com/Kunsip/sapphirepack/-/issues/80]
  '''
  alias Server.Accounts.User
  alias Phoenix.Token
  use Ecto.Schema
  import Ecto.Changeset

  schema "auth_tokens" do
    field :value, :string
    belongs_to :user, User

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(auth_token, user) do
    auth_token
    |> cast(%{}, [])
    |> put_assoc(:user, user)
    |> put_change(:value, generate_token(user))
    |> validate_required([:value, :user])
    |> unique_constraint(:value)
  end

  defp generate_token(nil), do: nil

  defp generate_token(user) do
    Token.sign(ServerWeb.Endpoint, "user", user.id)
  end
end

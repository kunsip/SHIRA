defmodule Server.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: true

  alias Server.AuthToken
  alias Server.Repo
  alias Server.Accounts.User
  alias Server.Mailer
  alias Server.Email

  def change_user() do
    User.changeset(%User{})
  end

  def begin(email) when is_bitstring(email) do
    case check_if_valid_changeset(email) do
      {:ok, %User{} = user} ->
        token =  generate_token(user)
        Email.welcome_email(email, token) |> Mailer.deliver_later
        {:ok, user}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end

  def authorize(magic_link) when is_bitstring(magic_link) do #Need to refactor authorize to be check_magic_link
      query = from a in AuthToken,
      where: a.inserted_at > from_now(-5, "minute") and a.value == ^magic_link #Logic for Magic Link duration. SHOULD be a macro or constant. Not burried in accounts.ex
      case Repo.one(query) |> Repo.preload(:user) do
        %AuthToken{} = token -> 
          {:ok, token.user }
        
        nil ->
          {:error, "Magic Link Invalid"}
      end
  end

  def get_user(user_id) when user_id > 0 do
    Repo.get(User, user_id)
  end



  defp check_if_valid_changeset(email) do
    user_changeset = User.changeset(%User{}, %{email: email})
    # We have to check one things
    # 1 That the changeset is valid before insertion
    # If it is not then we return an error and the changeset
    # Otherwise we find the user and create token
    if user_changeset.valid? do
      {:ok, return_user(user_changeset)}
    else 
      IO.puts "Error in the changeset"
      IO.inspect user_changeset
      {:error, user_changeset}
    end
  end

  defp return_user(user_changeset) do
    case Repo.insert(user_changeset) do
      {:ok, user} ->
        user
      {:error, %Ecto.Changeset{}} ->
        Repo.get_by(User, email: user_changeset.changes.email)
    end
  end

  defp generate_token(user) do
    authToken = AuthToken.changeset(%AuthToken{}, user) 
    case Repo.insert(authToken) do
      {:ok, token} ->
        token.value
      {:error, _} ->
        :error
      end
  end

end


# ┌────────────────────┐
# │ Check Email        │
# │                    │
# │ (Currently check to│
# │ make sure that @   │
# │ sign exists)       │
# └────────────────────┘
#            │
#            ▼
# ┌────────────────────┐
# │   Generate Token   │
# │                    │
# │(Currently create a │
# │ random token using │
# │ the Phoenix.Token  │
# │      module)       │
# └────────────────────┘
#            │
#            ▼
# ┌────────────────────┐
# │                    │
# │                    │
# │     Send Email     │
# │                    │
# │                    │
# │                    │
# └────────────────────┘
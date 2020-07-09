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
        generate_token(user)
        Email.welcome_email |> Mailer.deliver_now
        {:ok, user}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end


  defp check_if_valid_changeset(email) do
    IO.puts "Checking Email in 'check_if_valid_changeset'"
    IO.inspect email
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
    AuthToken.changeset(%AuthToken{}, user) 
    |> Repo.insert
    |> IO.inspect 
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
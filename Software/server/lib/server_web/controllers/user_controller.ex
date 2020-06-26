defmodule ServerWeb.UserController do
  # Import nessary controller API
  use ServerWeb, :controller

  alias Server.Accounts
  alias Server.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{}) #We want to receive a changeset back so that we can properly perform validateions, cast parameters and such
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_magic_link(user_params) do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))
      
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

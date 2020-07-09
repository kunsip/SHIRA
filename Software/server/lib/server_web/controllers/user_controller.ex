defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  alias Server.Accounts
  alias Server.Accounts.User

  def index(conn, _params) do
    changeset = Accounts.change_user()
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.begin(user_params["email"]) do
      {:ok, user} ->
        conn
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "Rendering Changeset in User Controller"
        IO.inspect changeset
        changeset = %{changeset | action: :insert} #Force Changeset to render errors
        render(conn, "index.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => magic_link}) do
    case Accounts.authorize(magic_link) do
      {:ok, _ } ->
        render(conn, "show.html", magic_link: magic_link)

      {:error, _} ->
        render(conn, "error.html", magic_link: magic_link)
    end
  end
end

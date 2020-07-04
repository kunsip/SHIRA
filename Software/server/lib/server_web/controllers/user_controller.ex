defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  alias Server.Accounts
  alias Server.Accounts.User

  def index(conn, _params) do
    users = Accounts.change_user()
    render(conn, "index.html", changeset: changeset)
  end

end

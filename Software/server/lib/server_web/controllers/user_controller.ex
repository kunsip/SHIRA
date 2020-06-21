defmodule ServerWeb.UserController do
    use ServerWeb, :controller #Import nessary controller API

    alias Server.Accounts

    def index(conn, _params) do
        users = Accounts.list_users()
        render(conn, "index.html", users: users)
    end

    def show(conn, %{"id" => id}) do
        user = Accounts.get_user(id)
        render(conn, "show.html", user: user)
    end
end
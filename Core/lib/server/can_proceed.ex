defmodule Server.CanProceed do
  import Plug.Conn
  import Phoenix.Controller

  alias Server.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    if current_user = Plug.Conn.get_session(conn, :user_id) do
      conn
    else
      conn
      |> redirect(to: "/")
      |> halt()
    end
  end
end

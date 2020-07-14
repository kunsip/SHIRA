defmodule Server.CanProceed do
  @moduledoc """
  Allows connection to pass iff user id is connected to session otherwise redirects to root
  """
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

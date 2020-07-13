defmodule Server.Auth do
  # Access to Plug.Conn sorta like inheritance
  import Plug.Conn
  # require is for DSL
  # use allows the module being used to inject code into module calling use X

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Server.Accounts.get_user(user_id)
    # We assign the user to current_user or nil
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    # Assign dispears at the end of thje request. 
    |> assign(:current_user, user)
    # Keeps data in session until clear/exipred
    |> put_session(:user_id, user.id)
    # Prevents session fixation attacks. 
    |> configure_session(renew: true)
  end

  # Not sure if ever 
  def logout(conn, _opts) do
    # Dropping entire session (we need to somehow hook into a onpageleave or ontabclose and trigger this last call.
    configure_session(conn, drop: true)
  end
end

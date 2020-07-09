defmodule Server.Auth do
    import Plug.Conn #Access to Plug.Conn sorta like inheritance
    #require is for DSL
    #use allows the module being used to inject code into module calling use X

    def init(opts), do: opts

    def call(conn, _opts) do
        user_id = get_session(conn, :user_id)
        user = user_id && Server.Accounts.get_user(user_id)
        assign(conn, :current_user, user) #We assign the user to current_user or nil
    end

    def login(conn, user) do
        conn
        |> assign(:current_user, user)#Assign dispears at the end of thje request. 
        |> put_session(:user_id, user.id) #Keeps data in session until clear/exipred
        |> configure_session(renew: true) #Prevents session fixation attacks. 
        
    end

    def logout(conn, _opts) do #Not sure if ever 
        configure_session(conn, drop: true)#Dropping entire session (we need to somehow hook into a onpageleave or ontabclose and trigger this last call.
    end


end	

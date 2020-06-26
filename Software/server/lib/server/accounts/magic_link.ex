defmodule Server.Accounts.MagicLink do
    @moduledoc """
    Provides signin services to users sending to users inbox a signin link
    """

    use Ecto.Schema
    import Ecto.Changeset

    schema "magic_links" do
        field :random_string, :string
        belongs_to :user, Server.Accounts.User #Now we can access the user via Magic_Link.user 
        #Even though it adds user_id we ignore that. This belongs to the user plain and simple.

        timestamps()
    end

end
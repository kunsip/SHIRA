defmodule Server.Accounts.MagicLink do
    @moduledoc """
    Provides signin services to users sending to users inbox a signin link
    """

    use Ecto.Schema
    alias Server.Accounts.SecureLinkGeneration
    import Ecto.Changeset

    schema "magic_links" do
        field :random_string, :string
        belongs_to :user, Server.Accounts.User #Now we can access the user via Magic_Link.user 
        #Even though it adds user_id we ignore that. This belongs to the user plain and simple.

        timestamps()
    end

    @doc false
    def changeset(magic_link, params \\ %{}) do
        magic_link
        |> cast(params, [:random_string])
        |> validate_required([:random_string])
    end

    def create_link(user) do
        item = changeset(%{random_string: SecureLinkGeneration.generate()}, %{})
        IO.puts inspect item
    end
end
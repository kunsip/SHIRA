defmodule Server.Repo.Migrations.AddTimestampsToMagicLink do
  use Ecto.Migration

  def change do
     alter table(:magic_links) do
      timestamps()
    end
  end
end

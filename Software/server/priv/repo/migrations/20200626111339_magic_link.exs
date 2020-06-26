defmodule Server.Repo.Migrations.MagicLink do
  use Ecto.Migration

  def change do
    create table(:magic_links) do
      add :random_string, :string

    end
  end
end

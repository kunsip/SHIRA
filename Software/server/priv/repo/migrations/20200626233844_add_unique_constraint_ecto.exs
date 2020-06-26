defmodule Server.Repo.Migrations.AddUniqueConstraintEcto do
  use Ecto.Migration

  def change do
    alter table(:magic_links) do
      create unique_index(:magic_links, [:random_string])
    end
  end

  def up do
    create unique_index(:magic_links, [:random_string])
  end

  def down do
    drop unique_index(:magic_links, [:random_string])
  end
end

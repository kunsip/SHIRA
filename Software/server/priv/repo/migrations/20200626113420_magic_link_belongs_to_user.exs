defmodule Server.Repo.Migrations.MagicLinkBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:magic_links) do
      add :user_id, references(:users)
    end
  end
end

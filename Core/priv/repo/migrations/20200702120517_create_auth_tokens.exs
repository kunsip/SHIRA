defmodule Server.Repo.Migrations.CreateAuthTokens do
  use Ecto.Migration

  def change do
    create table(:auth_tokens) do
      add :value, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(updated_at: false)
    end

    create index(:auth_tokens, [:user_id])
    # Prevents duplicate authentication tokens from being generated
    create unique_index(:auth_tokens, [:value])
  end
end

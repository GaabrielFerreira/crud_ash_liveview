defmodule Atividade0903.Aula.Aluno do
  use Ash.Resource,
  otp_app: :atividade0903,
  domain: Atividade0903.Aula,
  data_layer: AshPostgres.DataLayer,
  extensions: [AshGraphql.Resource]

  graphql do
    type :aluno

    queries do
      get :read_aluno, :read
      list :list_alunos, :read
    end

    mutations do
      create :create_aluno, :create
      update :update_aluno, :update
      destroy :destroy_aluno, :destroy
    end
  end

  postgres do
    table "alunos"
    repo Atividade0903.Repo
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :name, :string, allow_nil?: false, public?: true
    attribute :ra, :string, allow_nil?: false, public?: true
    attribute :age, :integer, allow_nil?: false, public?: true
    attribute :period, :integer, allow_nil?: false, public?: true
  end
end

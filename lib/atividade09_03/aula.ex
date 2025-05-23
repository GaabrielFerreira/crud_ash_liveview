defmodule Atividade0903.Aula do
  use Ash.Domain,
    extensions: [AshGraphql.Domain]

  graphql do
    root_level_errors? true
    authorize? true
  end

  resources do
    resource Atividade0903.Aula.Aluno
  end
end

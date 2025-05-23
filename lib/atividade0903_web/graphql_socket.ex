defmodule Atividade0903Web.GraphqlSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: Atividade0903Web.GraphqlSchema

  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end

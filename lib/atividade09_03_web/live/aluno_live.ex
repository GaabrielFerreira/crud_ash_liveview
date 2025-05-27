defmodule Atividade0903Web.AlunoLive do
  use Atividade0903Web, :live_view
  alias Atividade0903.Aula.Aluno

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:alunos, list_alunos())
     |> assign(:form_data, %{})
     |> assign(:editing_id, nil)
     |> assign(:show_form, false)}
  end

  def handle_event("show_form", _params, socket) do
    {:noreply,
     socket
     |> assign(:show_form, true)
     |> assign(:editing_id, nil)
     |> assign(:form_data, %{})}
  end

  def handle_event("hide_form", _params, socket) do
    {:noreply,
     socket
     |> assign(:show_form, false)
     |> assign(:editing_id, nil)
     |> assign(:form_data, %{})}
  end

  def handle_event("create_aluno", %{"aluno" => aluno_params}, socket) do
    case Ash.create(Aluno, aluno_params) do
      {:ok, _aluno} ->
        {:noreply,
         socket
         |> assign(:alunos, list_alunos())
         |> assign(:show_form, false)
         |> assign(:form_data, %{})
         |> put_flash(:info, "Aluno criado com sucesso!")}

      {:error, _error} ->
        {:noreply, put_flash(socket, :error, "Erro ao criar aluno")}
    end
  end

  def handle_event("edit_aluno", %{"id" => id}, socket) do
    aluno = Ash.get!(Aluno, id)

    {:noreply,
     socket
     |> assign(:show_form, true)
     |> assign(:editing_id, id)
     |> assign(:form_data, %{
       "name" => aluno.name,
       "ra" => aluno.ra,
       "age" => aluno.age,
       "period" => aluno.period
     })}
  end

  def handle_event("update_aluno", %{"aluno" => aluno_params}, socket) do
    aluno = Ash.get!(Aluno, socket.assigns.editing_id)

    case Ash.update(aluno, aluno_params) do
      {:ok, _aluno} ->
        {:noreply,
         socket
         |> assign(:alunos, list_alunos())
         |> assign(:show_form, false)
         |> assign(:editing_id, nil)
         |> assign(:form_data, %{})
         |> put_flash(:info, "Aluno atualizado com sucesso!")}

      {:error, _error} ->
        {:noreply, put_flash(socket, :error, "Erro ao atualizar aluno")}
    end
  end

  def handle_event("delete_aluno", %{"id" => id}, socket) do
    aluno = Ash.get!(Aluno, id)

    case Ash.destroy(aluno) do
      :ok ->
        {:noreply,
         socket
         |> assign(:alunos, list_alunos())
         |> put_flash(:info, "Aluno excluído com sucesso!")}

      {:error, _error} ->
        {:noreply, put_flash(socket, :error, "Erro ao excluir aluno")}
    end
  end

  defp list_alunos do
    Ash.read!(Aluno)
  end

  # OU APENAS TUDO EM UM ARQUIVO...
  # def render(assigns) do
  #   ~H"""
  #       COLOCANDO TODO O CODIGO DE ALUNOS_LIVE.HTML.HEEX AQUI
  #   """
  # end
end

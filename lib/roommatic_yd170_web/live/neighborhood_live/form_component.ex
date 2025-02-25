defmodule RoommaticYd170Web.NeighborhoodLive.FormComponent do
  use RoommaticYd170Web, :live_component

  alias RoommaticYd170.Geography

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage neighborhood records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="neighborhood-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Neighborhood</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{neighborhood: neighborhood} = assigns, socket) do
    changeset = Geography.change_neighborhood(neighborhood)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"neighborhood" => neighborhood_params}, socket) do
    changeset =
      socket.assigns.neighborhood
      |> Geography.change_neighborhood(neighborhood_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"neighborhood" => neighborhood_params}, socket) do
    save_neighborhood(socket, socket.assigns.action, neighborhood_params)
  end

  defp save_neighborhood(socket, :edit, neighborhood_params) do
    case Geography.update_neighborhood(socket.assigns.neighborhood, neighborhood_params) do
      {:ok, neighborhood} ->
        notify_parent({:saved, neighborhood})

        {:noreply,
         socket
         |> put_flash(:info, "Neighborhood updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_neighborhood(socket, :new, neighborhood_params) do
    case Geography.create_neighborhood(neighborhood_params) do
      {:ok, neighborhood} ->
        notify_parent({:saved, neighborhood})

        {:noreply,
         socket
         |> put_flash(:info, "Neighborhood created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

defmodule RoommaticYd170Web.NeighborhoodLive.Index do
  use RoommaticYd170Web, :live_view

  alias RoommaticYd170.Geography
  alias RoommaticYd170.Geography.Neighborhood

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :neighborhoods, Geography.list_neighborhoods())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Neighborhood")
    |> assign(:neighborhood, Geography.get_neighborhood!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Neighborhood")
    |> assign(:neighborhood, %Neighborhood{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Neighborhoods")
    |> assign(:neighborhood, nil)
  end

  @impl true
  def handle_info({RoommaticYd170Web.NeighborhoodLive.FormComponent, {:saved, neighborhood}}, socket) do
    {:noreply, stream_insert(socket, :neighborhoods, neighborhood)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    neighborhood = Geography.get_neighborhood!(id)
    {:ok, _} = Geography.delete_neighborhood(neighborhood)

    {:noreply, stream_delete(socket, :neighborhoods, neighborhood)}
  end
end

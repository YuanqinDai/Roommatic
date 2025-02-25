defmodule RoommaticYd170Web.NeighborhoodLive.Show do
  use RoommaticYd170Web, :live_view

  alias RoommaticYd170.Geography

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:neighborhood, Geography.get_neighborhood!(id))}
  end

  defp page_title(:show), do: "Show Neighborhood"
  defp page_title(:edit), do: "Edit Neighborhood"
end

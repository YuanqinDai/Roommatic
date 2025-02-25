defmodule RoommaticYd170Web.ApartmentLive.Show do
  use RoommaticYd170Web, :live_view

  alias RoommaticYd170.Apartments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    apartment = Apartments.get_apartment_with_residents!(id)
    unsubscribe_other_apartments()
    if connected?(socket), do: Apartments.subscribe(apartment)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:apartment, apartment)
     |> assign(:resident, Apartments.get_resident!(socket.assigns.current_user.id))}
  end

  defp page_title(:show), do: "Show Apartment"
  defp page_title(:edit), do: "Edit Apartment"
  defp unsubscribe_other_apartments() do
    RoommaticYd170.PubSub
    |> Registry.keys(self())
    |> Enum.map(fn topic -> Phoenix.PubSub.unsubscribe(RoommaticYd170.PubSub,
    topic) end)
  end
  @impl true
  def handle_event("occupy", _, socket) do
    {:ok, updated_resident} = Apartments.move_resident_in(socket.assigns.apartment, socket.assigns.resident)
    {:noreply, assign(socket, resident: updated_resident)}
  end

  def handle_event("vacate", _, socket) do
    {:ok, updated_resident} = Apartments.move_resident_out(socket.assigns.apartment, socket.assigns.resident)
    {:noreply, assign(socket, resident: updated_resident)}
  end

  @impl true
  def handle_info({:residents_updated, apartment}, socket) do
    resident = Apartments.get_resident!(socket.assigns.current_user.id)
    {:noreply, assign(socket, apartment: apartment, resident: resident)}
  end
end

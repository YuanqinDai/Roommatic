defmodule RoommaticYd170Web.ApartmentLive.FormComponent do
  use RoommaticYd170Web, :live_component

  alias RoommaticYd170.Apartments
  alias RoommaticYd170.Geography

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage apartment records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="apartment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:street_address]} type="text" label="Street address" />
        <.input field={@form[:bedrooms]} type="number" label="Bedrooms" />
        <.input field={@form[:rent]} type="number" label="Rent" step="any" />
        <.input field={@form[:notes]} type="text" label="Notes" />
        <%!-- Map a list of cities into a list of tuples where each tuple contains the city's name and its corresponding id --%>
        <.input
          field={@form[:city_id]}
          type="select"
          label="City"
          options={Enum.map(@cities, &{&1.name, &1.id})}
          prompt="Select a city"
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Apartment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{apartment: apartment} = assigns, socket) do
    changeset = Apartments.change_apartment(apartment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:cities, Geography.list_cities())
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"apartment" => apartment_params}, socket) do
    changeset =
      socket.assigns.apartment
      |> Apartments.change_apartment(apartment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"apartment" => apartment_params}, socket) do
    save_apartment(socket, socket.assigns.action, apartment_params)
  end

  defp save_apartment(socket, :edit, apartment_params) do
    case Apartments.update_apartment(socket.assigns.apartment, apartment_params) do
      {:ok, apartment} ->
        notify_parent({:saved, apartment})

        {:noreply,
         socket
         |> put_flash(:info, "Apartment updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_apartment(socket, :new, apartment_params) do
    case Apartments.create_apartment(apartment_params) do
      {:ok, apartment} ->
        notify_parent({:saved, apartment})

        {:noreply,
         socket
         |> put_flash(:info, "Apartment created successfully")
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

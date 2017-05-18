defmodule XUber.TrackerChannel do
  use XUber.Web, :channel

  alias XUber.Coordinator

  def join("tracker:lobby", payload=%{"name" => name}, socket) do
    if authorized?(payload) do
      Coordinator.register(name)

      send(self(), :after_join)

      {:ok, assign(socket, :name, name)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    push(socket, "welcome", %{names: Coordinator.known})
    broadcast(socket, "joined", %{names: [socket.assigns[:name]]})

    {:noreply, socket}
  end

  def handle_in("move", payload=%{"name" => name, "coords" => coords}, socket) do
    Coordinator.move(name, coords)

    broadcast(socket, "moved", payload)

    {:reply, {:ok, %{}}, socket}
  end

  defp authorized?(_payload) do
    true
  end

  def terminate(_reason, socket) do
    name = socket.assigns[:name]

    Coordinator.drop(name)

    broadcast(socket, "left", %{names: [name]})

    {:stop, :shutdown, socket}
  end
end

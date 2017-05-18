defmodule XUber.Coordinator do
  @name __MODULE__

  def start_link,
    do: Agent.start_link(fn -> %{} end, name: @name)

  def register(name),
    do: Agent.update(@name, &Map.put(&1, name, []))

  def known,
    do: Agent.get(@name, &Map.keys(&1))

  def positions do
    Agent.get(@name, fn names ->
      for {key, coords} <- names, into: %{} do
        {key, List.first(coords)}
      end
    end)
  end

  def move(name, coords) do
    Agent.update(@name, fn names ->
      Map.update(names, name, [coords], &[coords | &1])
    end)
  end

  def drop(name) do
    Agent.update(@name, fn names ->
      Map.delete(names, name)
    end)
  end
end

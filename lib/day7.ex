defmodule Day7 do
  def update_graph([name, _weight, nil], graph) do
    graph
    |> Graph.add_vertex(name)
  end

  def update_graph([name, _weight, children], graph) do
    graph
    |> Graph.add_vertex(name)
    |> Graph.add_edges(Enum.map(children, fn child -> Graph.Edge.new(name, child) end))
  end

  @doc """
    ## Examples
      iex(9)> Day7.parse_line("cvpimoj (164) -> eebyqij, vjipe, tdaxn")
      ["cvpimoj", 164, ["eebyqij", " vjipe", " tdaxn"]]

      iex(9)> Day7.parse_line("osaqp (85)")
      ["osaqp", 85, nil]
  """
  def parse_line(line) do
    [_, leaf, weight | tail] = Regex.run(~r/(\w+) \((\d+)\)(?: -> (.+))?$/, line)

    children =
      case tail do
        [children | _] -> String.split(children, ", ", trim: true)
        [] -> nil
      end

    [leaf, String.to_integer(weight), children]
  end

  def parse_input(string) do
    string
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(Graph.new(), &update_graph/2)
  end

  def read_input do
    {:ok, string} = File.read("scripts/input7.txt")

    parse_input(string)
  end
end

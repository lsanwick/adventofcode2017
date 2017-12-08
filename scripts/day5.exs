{:ok, string} = File.read("scripts/input5.txt")

maze = Day5.parse_string(string)
{count, _final} = Day5.jump(maze)
IO.puts count

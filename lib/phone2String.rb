MAPPING = {
  "1" => ["1"],
  "2" => ["A", "B", "C"],
  "3" => ["D", "E", "F"],
  "4" => ["G", "H", "I"],
  "5" => ["J", "K", "L"],
  "6" => ["M", "N", "O"],
  "7" => ["P", "Q", "R", "S"],
  "8" => ["T", "U", "V"],
  "9" => ["W", "X", "Y", "Z"],
  "0" => ["0"]
}

def phone2string(input)
  return [] if input.empty?
  return MAPPING[input[0]] if input.length == 1
  MAPPING[input[0]].flat_map do |char|
    phone2string(input[1..-1]).map do |str|
      "#{char}#{str}"
    end
  end
end

def phone2string_tco(input, results = [])
  return results if input.empty?
  new_results = MAPPING[input[0]].flat_map do |char|
    if results.empty?
      char
    else
      results.map do |str|
        "#{str}#{char}"
      end
    end
  end

  phone2string_tco(input[1..-1], new_results)
end


begin_time = Time.now
puts phone2string('408833892640883').length
end_time = Time.now
puts "#{(end_time - begin_time) * 1000}ms"


begin_time = Time.now
puts phone2string_tco('408833892640883').length
end_time = Time.now
puts "TCO: #{(end_time - begin_time) * 1000}ms"
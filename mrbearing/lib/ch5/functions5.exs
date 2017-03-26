# Enum.map [1,2,3,4] , fn x -> x + 2 end
IO.puts "#### Enum.map [1,2,3,4] , fn x -> x + 2 end ####\n"
IO.inspect Enum.map [1,2,3,4] , &(&1 + 2)
IO.puts "\n"

# Enum.each [1,2,3,4] , fn x -> IO.inspect x end
IO.puts "#### Enum.each [1,2,3,4] , fn x -> IO.inspect x end ####"
IO.inspect Enum.each [1,2,3,4] , &(IO.inspect &1)


# prefix 関数を書く

prefix = fn pre -> (fn s -> pre <> s end ) end

mrs = prefix.("Mrs")
IO.puts mrs.("Smith")

IO.puts prefix.("Elixir").("Rocks")


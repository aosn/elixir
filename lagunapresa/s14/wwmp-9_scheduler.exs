
# >File.ls!
# ["wwmp-1.ex", "wwmp-2.exs", "wwmp-3.exs", "wwmp-4.exs",
# "wwmp-5-1.exs", "wwmp-5-2.exs", "wwmp-8_fib.exs",
# "wwmp-8_fibsolver.exs", "wwmp-8_scheduler.exs",
# "wwmp-9_scheduler.exs"]
# dir = path
# files = File.ls! dir
#
# List.map(file, fn f ->
#   File.read!(f)
#   |> String.trim
#   |> String.split(~r{\bcat\b})
#   |> length
# end)

File.read!("wwmp-1.ex") |> String.trim |> String.split(~r{\bcat\b}) |> length-1

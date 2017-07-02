defmodule StringsAndBinaries7 do
  def apply(src, sales_tax), do: parse(src) |> sales_tax.()
  def parse(src) do
    {:ok, f} = File.open(src)
    _each(fn () -> IO.read(f, :line) end, [], [])
  end
  defp _each(read_line, header, body) do
    case read_line.() do
      :eof -> body
      row  ->
        r = String.trim(row) |> String.split(",")
        if Enum.empty?(header) do
          _each(read_line, Enum.map(r, &String.to_atom/1), body)
        else
          conv = case Enum.zip([header, r]) do
            [id: id, ship_to: ship_to, net_amount: net_amount] ->
              [id: String.to_integer(id), ship_to: String.lstrip(ship_to, ?:) |> String.to_atom, net_amount: String.to_float(net_amount)]
          end
          _each(read_line, header, body ++ [conv])
        end
    end
  end
end

# iex(1)> c"../s10/ListsAndRecursion-8.exs"
# [MyTax]
# iex(2)> tax_rates = [ NC: 0.075, TX: 0.08 ]
# [NC: 0.075, TX: 0.08]
# iex(3)> c"StringsAndBinaries-7.exs"
# [StringsAndBinaries7]
# iex(4)> StringsAndBinaries7.parse("src.csv") |> MyTax.with_total_amount(tax_rates)
# [[id: 123, ship_to: :NC, net_amount: 100.0, total_amount: 107.5],
#  [id: 124, ship_to: :OK, net_amount: 35.5, total_amount: 35.5],
#  [id: 125, ship_to: :TX, net_amount: 24.0, total_amount: 25.92],
#  [id: 126, ship_to: :TX, net_amount: 44.8, total_amount: 48.384],
#  [id: 127, ship_to: :NC, net_amount: 25.0, total_amount: 26.875],
#  [id: 128, ship_to: :MA, net_amount: 10.0, total_amount: 10.0],
#  [id: 129, ship_to: :CA, net_amount: 102.0, total_amount: 102.0],
#  [id: 120, ship_to: :NC, net_amount: 50.0, total_amount: 53.75]]

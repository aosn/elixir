defmodule TaxOrderReader do
  def load(filename) do
    file = File.open!(filename)
    header = IO.read(file, :line)
              |> _parse_header
    result = IO.stream(file, :line)
              |> Enum.map(&(_parse_record(header, &1)))
    :ok = File.close(file)
    result
  end

  ##
  ## Parse CSV record
  ## 
  defp _parse_record(header_atom, line) do
    fields = String.strip(line)
              |> String.split(",")
              |> Enum.map(&(String.strip(&1)))
    _convert_fields(header_atom, fields)
  end

  ##
  ## Convert each element of CSV field
  ##
  defp _convert_fields([], []),     do: []
  defp _convert_fields([], [_|_]),  do: []
  defp _convert_fields([_|_], []),  do: []
  defp _convert_fields([head_a | tail_a], [head_v | tail_v]) do
    [{head_a, _convert_native(head_v)} | _convert_fields(tail_a, tail_v)]
  end

  ##
  ## Convert to native value from string
  ##
  defp _convert_native(str_value) do
    cond do
      String.match?(str_value, ~r/^\d+$/)       -> String.to_integer(str_value)
      String.match?(str_value, ~r/^\d+\.\d+$/)  -> String.to_float(str_value)
      String.match?(str_value, ~r/^:/)          -> String.to_atom(String.lstrip(str_value,?:))
      true -> str_value
    end
  end

  ##
  ## Convert to atom list
  ##
  defp _parse_header(line) do
    String.strip(line)
      |> String.split(",")
      |> Enum.map(&(String.to_atom(&1)))
  end
end

## This is ListsAndRecursion-8
defmodule TaxOrder do
  def calc_orders_with_tax(orders_list, tax_rates_list) do
    for order <- orders_list do
      tax = case tax_rates_list[order[:ship_to]] do
        nil -> 0
        tax -> tax
      end
      [
        id: order[:id],
        ship_to: order[:ship_to],
        net_amount: order[:net_amount],
        total_amount: (1.0+tax) * order[:net_amount]
      ]
    end
  end
end

defmodule TaxOrderCalculator do
  @tax_rates  [ NC: 0.075, TX: 0.08 ]

  def sale_tax(orders) do
    TaxOrder.calc_orders_with_tax(orders, @tax_rates)
  end
end

orders = TaxOrderReader.load("StringsAndBinaries-7.csv")
IO.inspect TaxOrderCalculator.sale_tax(orders)

#[[id: 123, ship_to: :NC, net_amount: 100.0, total_amount: 107.5],
# [id: 124, ship_to: :OK, net_amount: 35.5, total_amount: 35.5],
# [id: 125, ship_to: :TX, net_amount: 24.0, total_amount: 25.92],
# [id: 126, ship_to: :TX, net_amount: 44.8, total_amount: 48.384],
# [id: 127, ship_to: :NC, net_amount: 25.0, total_amount: 26.875],
# [id: 128, ship_to: :MA, net_amount: 10.0, total_amount: 10.0],
# [id: 129, ship_to: :CA, net_amount: 102.0, total_amount: 102.0],
# [id: 120, ship_to: :NC, net_amount: 50.0, total_amount: 53.75]]
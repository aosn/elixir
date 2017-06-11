defmodule MyList do
  def foldr( _, [], y ), do: y
  def foldr( f, [ x | xs ], y ), do: f.( x, foldr( f, xs, y ) )
end  

defmodule TotalAmount do
  import MyList

  defp maybe_rate( rates, order ), do:
    Keyword.get( rates, Keyword.get( order, :ship_to ) )
  defp rate( rates, order) do
    if maybe_rate( rates, order ) == nil do 0 else maybe_rate( rates, order ) end
  end
  defp amount( order ), do: Keyword.get( order, :net_amount )
  
  defp total_amount( rates, order ), do:
     rate( rates, order ) * amount( order ) + amount( order )
  defp _appender( rates, order, acc ), do:
    [ Keyword.merge( order, [ total_amount: total_amount( rates, order ) ] ) | acc ]
  
  def appender( rates, orders ), do:  foldr( &( _appender( rates, &1, &2 ) ), orders, [] )
end

rates = [ NC: 0.075, TX: 0.08 ]
orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount:  50.00 ]
]

IO.inspect TotalAmount.appender( rates, orders )
# evaluated to...
# [[id: 123, ship_to: :NC, net_amount: 100.0, total_amount: 107.5],
#  [id: 124, ship_to: :OK, net_amount: 35.5, total_amount: 35.5],
#  [id: 125, ship_to: :TX, net_amount: 24.0, total_amount: 25.92],
#  [id: 126, ship_to: :TX, net_amount: 44.8, total_amount: 48.384],
#  [id: 127, ship_to: :NC, net_amount: 25.0, total_amount: 26.875],
#  [id: 128, ship_to: :MA, net_amount: 10.0, total_amount: 10.0],
#  [id: 129, ship_to: :CA, net_amount: 102.0, total_amount: 102.0],
#  [id: 130, ship_to: :NC, net_amount: 50.0, total_amount: 53.75]]


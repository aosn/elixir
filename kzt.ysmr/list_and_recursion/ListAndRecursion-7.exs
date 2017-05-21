defmodule MyList do
  def span( x, y ) when x > y, do: :undefined
  def span( x, y ) when x == y , do: [ x ]
  def span( x, y ), do: [ x | span( x + 1, y ) ]

  def foldr( _, [], y ), do: y
  def foldr( f, [ x | xs ], y ), do: f.( x, foldr( f, xs, y ) )
end  

defmodule Eratosthenes do
  import MyList

  defp filtering( i, j, acc ) when i == j, do: [ j | acc ]
  defp filtering( i, j, acc ) when rem( j, i ) != 0, do: [ j | acc ]
  defp filtering( _, _, acc ), do: acc

  defp _eratosthenes( i, acc, n ) when i > n, do: acc
  defp _eratosthenes( i, acc, n ), do: _eratosthenes( i + 1, foldr( fn ( j, acc0 ) -> filtering( i, j, acc0 ) end, acc, [] ), n )
  
  def eratosthenes( n ), do: _eratosthenes( 2, span( 2, n ), n / 2 )
end 

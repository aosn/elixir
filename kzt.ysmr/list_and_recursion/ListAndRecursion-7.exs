defmodule MyList do
  def span( x, y ) when x > y, do: :undefined
  def span( x, y ) when x == y , do: [ x ]
  def span( x, y ), do: [ x | span( x + 1, y ) ]

  def foldl( _, y, [] ), do:  y
  def foldl( f, y, [ x | xs ] ), do: foldl( f, f.( y, x ), xs )
  
  def reverse( xs ), do: foldl( fn ( acc, x ) -> [ x | acc ] end, [], xs )
end  

defmodule Eratosthenes do
  import MyList

  defp filtering( i, acc, j ) when i == j, do: [ j | acc ]
  defp filtering( i, acc, j ) when rem( j, i ) == 0, do: acc
  defp filtering( _, acc, j ), do: [ j | acc ]

  defp _eratosthenes( i, acc, n ) when i > n, do: acc
  defp _eratosthenes( i, acc, n ), do: _eratosthenes( i + 1, foldl( fn ( acc0, j ) -> filtering( i, acc0, j ) end, [], acc ), n )
  
  def eratosthenes( n ) when rem( div( n, 2 ), 2 ) == 0, do: reverse( _eratosthenes( 2, span( 3, n ), n / 2 ) )
  def eratosthenes( n ), do: _eratosthenes( 2, span( 3, n ), n / 2 )
end 

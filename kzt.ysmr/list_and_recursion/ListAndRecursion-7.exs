defmodule MyList do
  def span( x, y ) when x > y, do: :undefined
  def span( x, y ) when x == y , do: [ x ]
  def span( x, y ), do: [ x | span( x + 1, y ) ]

  def foldl( _, y, [] ), do: y
  def foldl( f, y, [ x | xs ] ), do: foldl( f, f.( y, x ), xs )
  
  def foldr( _, [], y ), do: y
  def foldr( f, [ x | xs ], y ), do: f.( x, foldr( f, xs, y ) )
end  

defmodule Eratosthenes do
  import MyList

  defp filtering( i, j, acc ) when i == j, do: [ j | acc ]
  defp filtering( i, j, acc ) when rem( j, i ) != 0, do: [ j | acc ]
  defp filtering( _, _, acc ), do: acc

  defp __eratosthenes( i ), do: fn ( j, acc0 ) -> filtering( i, j, acc0 ) end
  defp _eratosthenes, do: fn ( acc, i ) -> foldr( __eratosthenes( i ), acc, [] ) end
  
  def eratosthenes( n ), do: foldl( _eratosthenes, span( 2, n ), span( 2, div( n, 2 ) ) )
end

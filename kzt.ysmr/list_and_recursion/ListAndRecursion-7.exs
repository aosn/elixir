defmodule MyList do
  def span( i, j ) when i > j, do: :undefined
  def span( i, j ) when i == j , do: [ i ]
  def span( i, j ), do: [ i | span( i + 1, j ) ]

  def foldl( _, y, [] ), do: y
  def foldl( f, y, [ x | xs ] ), do: foldl( f, f.( y, x ), xs )
  
  def foldr( _, [], y ), do: y
  def foldr( f, [ x | xs ], y ), do: f.( x, foldr( f, xs, y ) )
end  

defmodule Eratosthenes do
  import MyList

  defp _elim( i, j, acc ) do
    if i == j || rem( j, i ) != 0 do [ j | acc ] else acc end
  end
  
  defp elim( acc, i ), do: foldr( &( _elim( i, &1, &2 ) ), acc, [] )
  def up_to( n ), do: foldl( &( elim( &1, &2 ) ), span( 2, n ), span( 2, div( n, 2 ) ) )
end

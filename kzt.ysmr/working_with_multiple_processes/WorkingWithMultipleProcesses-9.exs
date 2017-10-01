
defmodule WordOccurrenceCounter do

  def count( scheduler ) do
    send scheduler, { :ready, self }
    receive do
      { :count, file, client } ->
	send client, { :answer, file, :not_yet_implemented, self }
	count( scheduler )
      { :shutdown } ->
	exit( :normal )
    end
  end
end

defmodule Scheduler do
  
  def run( num_processes, module, func, to_calculate ) do
    ( 1..num_processes )
    |> Enum.map( fn(_) -> spawn( module, func, [ self ] ) end )
    |> schedule_processes( to_calculate, [] )
  end

  defp schedule_processes( processes, queue, results ) do
    receive do
      { :ready, pid } when length( queue ) > 0 ->
	[ file | tail ] = queue
	send pid, { :count, file, self }
	schedule_processes( processes ,tail, results )

      { :ready, pid } ->
      send pid, { :shutdown }
      if length( processes ) > 1 do
	schedule_processes( List.delete( processes, pid ), queue, results )
      else
	Enum.sort( results, fn { n1, _ }, { n2, _ } -> n1 <= n2 end )
      end

      { :answer, number, result, _pid } ->
	schedule_processes( processes, queue, [ { number, result } | results ] )
    end
  end
end

to_process = File.ls!

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(
    Scheduler, :run,
    [ num_processes, WordOccurrenceCounter, :count, to_process ]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end
  :io.format "~2B     ~.2f~n", [ num_processes, time / 1000000.0 ]
end

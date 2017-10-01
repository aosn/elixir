defmodule WordCounter do
  def count(scheduler, target_word) do
    send scheduler, { :ready, self() }
    receive do
      { :count, filename, client } ->
        send client, { :answer, filename, word_count(filename, target_word), self() }
        count(scheduler, target_word)
      { :shutdown } -> 
        exit(:normal)
    end
  end

  defp word_count(filename, word) do
    File.read!(filename)
    |> String.split(" ")
    |> Enum.count(&(&1 == word))
  end
end


defmodule Scheduler do
  def run(file_list, target_word, module, func) do
    file_list
    |> Enum.map(fn(_) -> spawn(module, func, [self(), target_word]) end)
    |> schedule_processes(file_list, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ filename | tail ] = queue
        send pid, {:count, filename, self()}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {_, n1}, {_, n2} -> n1 > n2 end)
        end
 
      {:answer, filename, result, _pid} -> 
        schedule_processes(processes, queue, [ {filename, result} | results ])
    end
  end
end

# 走査対象ファイル一覧取得
target_dir = "./"
File.cd!(target_dir)
file_list = File.ls!

# "cat"の単語数を数える
result = Scheduler.run(file_list, "cat", WordCounter, :count)
IO.puts inspect result

# [{"cat_03.txt", 3}, {"no_cat.txt", 0}, {"WorkingWithMultipleProcesses-9.exs", 0}]
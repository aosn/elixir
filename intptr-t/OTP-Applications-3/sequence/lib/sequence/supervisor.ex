defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_values) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_values])
    start_workers(sup, initial_values)
    result
  end

  def start_workers(sup, initial_values) do
    # スタッシュワーカーを開始
    {:ok, stash} = Supervisor.start_child(sup, worker(Sequence.Stash, [initial_values]))
    # そして、実際の Sequence サーバのスーバーバイザーを開始
    Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
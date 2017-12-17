defmodule Sequence.Stash do
  use GenServer
  require Logger

  @vsn "1"
  #####
  # 外部 API

  def start_link(current_values) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_values)
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  def save_value(pid, value) do
    GenServer.cast pid, {:save_value, value}
  end

  #####
  # GenServer の実装

  def handle_call(:get_value, _from, current_values) do
    {:reply, current_values, current_values}
  end

  def handle_cast({:save_value, value}, _current_value) do
    {:noreply, value}
  end

  def code_change("0", current_number, _extra) do
    new_state = [
      current_number: current_number,
      current_delta: 1
    ]
    Logger.info "Changing 'Stash' code from 0 to 1"
    Logger.info inspect current_number
    Logger.info inspect new_state
    {:ok, new_state}
  end  
end

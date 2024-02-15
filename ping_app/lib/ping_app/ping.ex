defmodule PingApp.Ping do
  use GenServer

  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_init_arg) do
    :net_kernel.monitor_nodes(true)
    {:ok, self()}
  end

  def handle_info({:nodeup, node}, pid) do
    :rpc.call(node, Process, :whereis, [PongApp.Pong])
    |> send({:ping, self()})

    {:noreply, self()}
  end

  def handle_info({:pong, pong_pid}, pid) do
    Logger.info("#{inspect(pid)}: Received ping from #{inspect(pong_pid)}")
    Process.send_after(pong_pid, {:ping, self()}, 1000)
    {:noreply, pid}
  end

  def handle_info(msg, pid) do
    Logger.info("#{pid}: Received: #{inspect(msg)}")

    {:noreply, pid}
  end
end

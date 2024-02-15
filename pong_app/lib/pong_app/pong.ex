defmodule PongApp.Pong do
  use GenServer

  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_init_arg) do
    :net_kernel.monitor_nodes(true)
    {:ok, UUID.uuid4()}
  end

  def handle_info({:ping, ping_pid}, pid) do
    Logger.info("#{inspect(pid)}: Received ping from #{inspect(ping_pid)}")
    Process.send_after(ping_pid, {:pong, self()}, 1000)
    {:noreply, pid}
  end

  def handle_info(msg, uuid) do
    Logger.info("#{uuid}: Received ping from #{inspect(msg)}")
    {:noreply, uuid}
  end
end

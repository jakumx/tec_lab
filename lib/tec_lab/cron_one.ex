defmodule TecLab.CronOne do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() 
    {:ok, state}
  end

  def handle_info(:work, state) do

    files_found = Redis.all()
    list_File = for n <- files_found do
      IO.inspect n
      file_found = Redis.get(n)
        |> Crypt.de
        |> String.split(",")
      file_found
    end
    csv_content(list_File)
    schedule_work()
    {:noreply, state}
  end

  defp csv_content(list_) do
    raw_csv_content = list_
      |> CSV.encode
      |> Enum.to_list
      |> to_string
      |> IO.inspect

      #TODO: download file 
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1 * 1 * 60 * 1000) # a minute
  end
end

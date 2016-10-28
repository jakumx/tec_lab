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
    #FIXME: add to list_File 
    list_File = []
    for n <- files_found do
      IO.inspect n
      file_found = Redis.get(n)
        |> Crypt.de
        |> String.split(",")
      new_file = List.insert_at([], -1, file_found)
        |> IO.inspect
      list_File ++ new_file
      IO.inspect list_File
    end
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

defmodule TecLab.PageController do
  use TecLab.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, params) do
    file = params["file"]

    if (file["for"].path) do
      # read the file
      file_content = File.read!(file["for"].path)
        # |> String.replace("\"", "")
        |> String.split("\n")
      file_name = file["for"].filename
        
      for n <- file_content do
        file_row = String.split(n, ",")
        file_crypt = Crypt.en(n)
        first = Enum.at(file_row,0)
          |> String.replace("\"", "")
        Redis.set(first, file_crypt)
      end

      render(conn, "success.html",  file: file_name)
    else
      render conn, "index.html"
    end

  end  
end

defmodule TecLab.FindController do
  use TecLab.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, params) do
    file_name = params["file_name"]

    if (file_name["for"]) do
      file_found = Redis.get(file_name["for"])
        |> Crypt.de
      if (file_found) do
        render(conn, "success.html", file_found: file_found)
      else
        render conn, "index.html"
      end
    else
      render conn, "index.html"
    end

  end
end

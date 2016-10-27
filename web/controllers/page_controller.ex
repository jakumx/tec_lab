defmodule TecLab.PageController do
  use TecLab.Web, :controller

  alias TecLab.Page

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, params) do
    IO.inspect params
    file = params["file"]

    if (file["for"].path) do
      # read the file
      file_content = File.read!(file["for"].path)
      file_name = file["for"].filename

      # encrypt file
      file_crypt = Crypt.en(file_content, file_name)

      #insert to redis
      Redis.set(file_name, file_crypt)

      render(conn, "success.html",  file: file_name)
    else
      render conn, "index.html"
    end

  end  
end

defmodule TecLab.FindController do
  use TecLab.Web, :controller

  alias TecLab.Find

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

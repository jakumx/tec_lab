defmodule Redis do
  import Exredis

  def get(key), do: start_link |> elem(1) |> query(["GET", key])
  def set(key, value), do: start_link |> elem(1) |> query(["SET", key, value])
  def all(), do: start_link |> elem(1) |> query(["KEYS", "*"])

end

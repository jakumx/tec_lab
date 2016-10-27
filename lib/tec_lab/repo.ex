defmodule TecLab.Repo do
  use Ecto.Repo, otp_app: :tec_lab, adapter: Mongo.Ecto
end

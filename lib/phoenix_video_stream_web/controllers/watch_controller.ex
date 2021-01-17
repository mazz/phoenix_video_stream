defmodule PhoenixVideoStreamWeb.WatchController do
  use PhoenixVideoStreamWeb, :controller
  import PhoenixVideoStream.Util

  alias PhoenixVideoStream.Multimedia.Video
  alias PhoenixVideoStream.Repo

  def show(%{req_headers: headers} = conn, %{"id" => id}) do

    IO.inspect(id, label: "video id")
    video = Repo.get!(Video, id)

    IO.inspect(video, label: "video video")

    send_video(conn, headers, video)
  end
end

defmodule PhoenixVideoStreamWeb.VideoController do
  use PhoenixVideoStreamWeb, :controller

  alias PhoenixVideoStream.Multimedia
  alias PhoenixVideoStream.Multimedia.Video
  alias PhoenixVideoStream.Repo

  import PhoenixVideoStream.Util, only: [build_video_path: 1]

  def index(conn, _params) do
    videos = Multimedia.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Multimedia.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    changeset = Video.changeset(%Video{}, video_params)
    case Repo.insert(changeset) do
      {:ok, video} ->
        persist_file(video, video_params["video_file"])

        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: Routes.video_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
  def show(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    changeset = Multimedia.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Multimedia.get_video!(id)

    case Multimedia.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: Routes.video_path(conn, :show, video))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    {:ok, _video} = Multimedia.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: Routes.video_path(conn, :index))
  end

  defp persist_file(video, %{path: temp_path}) do
    video_path = build_video_path(video)
    unless File.exists?(video_path) do
      video_path |> Path.dirname() |> File.mkdir_p()
      File.copy!(temp_path, video_path)
    end
  end
end

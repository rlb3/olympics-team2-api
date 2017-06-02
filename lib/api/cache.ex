defmodule API.Cache do
  use GenServer

  @moduledoc """
  Cache for the database queries. The cache is warmed on application start.
  """

  @doc "Start the Server"
  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc "Set the medal in the cache"
  def set_medals(data) do
    GenServer.cast(__MODULE__, {:set_medals, data})
  end

  @doc "Set the news in the cache"
  def set_news(data) do
    GenServer.cast(__MODULE__, {:set_news, data})
  end

  @doc "Get the medals"
  def get_medals do
    GenServer.call(__MODULE__, :medals)
  end

  @doc "Get the new"
  def get_news do
    GenServer.call(__MODULE__, :news)
  end

  @doc "Clear the cache"
  def clear do
    GenServer.cast(__MODULE__, :clear)
  end

  @doc false
  def init(_) do
    Process.send_after(self(), :init_medals, 1000)
    Process.send_after(self(), :init_news, 1000)
    {:ok, %{news: nil, medals: nil}}
  end

  @doc false
  def handle_cast(:clear, _state) do
    {:noreply, %{news: nil, medals: nil}}
  end

  @doc false
  def handle_cast({:set_medals, data}, state) do
    {:noreply, %{state | medals: data}}
  end

  @doc false
  def handle_cast({:set_news, data}, state) do
    {:noreply, %{state | news: data}}
  end

  @doc false
  def handle_call(:medals, _from, state) do
    {:reply, state.medals, state}
  end

  @doc false
  def handle_call(:news, _from, state) do
    {:reply, state.news, state}
  end

  @doc false
  def handle_info(:init_medals, state) do
    medals = API.Medal.distinct_countries
    |> Enum.map(fn country ->
      API.Medal.metal_object(for: country)
    end)
    {:noreply, %{state | medals: medals}}
  end

  @doc false
  def handle_info(:init_news, state) do
    news =
      API.TopNews
      |> API.Repo.all
      |> Enum.map(fn news ->
      %{news | photo_name: String.replace_prefix(news.photo_url, "/images/", "")}
    end)

      {:noreply, %{state | news: news}}
  end
end

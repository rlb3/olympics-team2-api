defmodule API.CacheTest do
  use ExUnit.Case

  test "Set Metal" do
    assert :ok == API.Cache.set_medals("metals")
    assert "metals" == API.Cache.get_medals
  end

  test "get news" do
    assert :ok == API.Cache.set_news("news")
    assert "news" == API.Cache.get_news
  end

  test "clear" do
    assert :ok == API.Cache.set_news("news")
    assert :ok == API.Cache.set_medals("metals")

    API.Cache.clear

    assert nil == API.Cache.get_news
    assert nil == API.Cache.get_medals
  end
end

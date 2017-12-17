defmodule Euros.HTTPTest do
  use ExUnit.Case, async: true

  describe "Euros.HTTP.fetch_pages/1" do
    test "get a web page" do
      assert %{body: _, headers: _, request_url: _, status_code: 200} = Euros.HTTP.fetch_pages("http://localhost:32768")
      assert %{body: _, headers: _, request_url: _, status_code: 200} = Euros.HTTP.fetch_pages("http://localhost:32768/index.html")
      assert %{body: _, headers: _, request_url: _, status_code: 200} = Euros.HTTP.fetch_pages("http://localhost:32768/about.html")
      assert %{body: _, headers: _, request_url: _, status_code: 200} = Euros.HTTP.fetch_pages("http://localhost:32768/nestedpath/index.html")
    end
  end
end

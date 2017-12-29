defmodule Euros.HTTPTest do
  use ExUnit.Case, async: true

  describe "Euros.HTTP.fetch_pages/1" do
    test "get a web page" do
      assert %{body: _, headers: _, request_url: _, status_code: 200} = Euros.HTTP.fetch_pages("https://euros-test.blogspot.jp/")
    end
  end

  describe "Euros.HTTP.fetch_pages/2" do
    test "get a web page" do
      assert %{body: _, headers: _, request_url: _, status_code: 200} = Euros.HTTP.fetch_pages("https://euros-test.blogspot.jp/", %Euros.HTTPOption{})
    end
  end
end

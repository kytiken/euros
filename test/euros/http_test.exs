defmodule Euros.HTTPTest do
  use ExUnit.Case, async: true

  describe "Euros.HTTP.fetch_pages/1" do
    test "get a web page" do
      assert %{body: _, headers: _, request_url: _, status_code: 200} =
               Euros.HTTP.fetch_pages("https://euros-test.blogspot.com/")
    end
  end

  describe "Euros.HTTP.fetch_pages/2" do
    test "get a web page" do
      assert %{body: _, headers: _, request_url: _, status_code: 200} =
               Euros.HTTP.fetch_pages("https://euros-test.blogspot.com/", %Euros.HTTPOption{})
    end
  end
end

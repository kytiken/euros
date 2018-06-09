defmodule Euros.PageTest do
  use ExUnit.Case, async: true

  describe "Euros.Page.link_uris/1" do
    test "get link uris from response" do
      "https://euros-test.blogspot.com"
      |> Euros.HTTP.fetch_pages()
      |> Euros.Page.link_uris()
      |> Enum.each(fn uri ->
        assert "euros-test.blogspot.com" === uri.host
      end)
    end
  end

  describe "Euros.Page.link_uris/2" do
    test "get link uris from response" do
      response = Euros.HTTP.fetch_pages("https://euros-test.blogspot.com")
      pattern = ~r/test1/
      links = Euros.Page.link_uris(response, pattern)

      assert [
               %URI{
                 authority: "euros-test.blogspot.com",
                 fragment: nil,
                 host: "euros-test.blogspot.com",
                 path: "/2017/12/test1.html",
                 port: 443,
                 query: nil,
                 scheme: "https",
                 userinfo: nil
               }
             ] === links
    end
  end
end

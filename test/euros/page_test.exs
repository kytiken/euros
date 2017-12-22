defmodule Euros.PageTest do
  use ExUnit.Case, async: true

  describe "Euros.Page.link_uris/1" do
    test "get link uris from response" do
      response = Euros.HTTP.fetch_pages("http://localhost:32768")
      links = Euros.Page.link_uris(response)
      assert [%URI{authority: "localhost:32768", fragment: nil,
              host: "localhost", path: "/about.html", port: 32_768,
              query: nil, scheme: "http", userinfo: nil},
             %URI{authority: "localhost:32768", fragment: nil,
              host: "localhost", path: "/php.php", port: 32_768,
              query: nil, scheme: "http", userinfo: nil},
             %URI{authority: "localhost:32768", fragment: nil,
              host: "localhost", path: "/nestedpath/index.html", port: 32_768,
              query: nil, scheme: "http", userinfo: nil}] == links


    end
  end
end

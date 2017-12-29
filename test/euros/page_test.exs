defmodule Euros.PageTest do
  use ExUnit.Case, async: true

  describe "Euros.Page.link_uris/1" do
    test "get link uris from response" do
      response = Euros.HTTP.fetch_pages("https://euros-test.blogspot.jp")
      links = Euros.Page.link_uris(response)
      assert [%URI{authority: "euros-test.blogspot.jp", fragment: nil,
                host: "euros-test.blogspot.jp", path: nil, port: 443, query: nil,
                scheme: "https", userinfo: nil},
              %URI{authority: "euros-test.blogspot.jp", fragment: nil,
                host: "euros-test.blogspot.jp", path: "/2017/12/image-page-test.html",
                port: 443, query: nil, scheme: "https", userinfo: nil},
              %URI{authority: "euros-test.blogspot.jp", fragment: nil,
                host: "euros-test.blogspot.jp", path: "/2017/12/other-host-link-test.html",
                port: 443, query: nil, scheme: "https", userinfo: nil},
              %URI{authority: "euros-test.blogspot.jp", fragment: nil,
                host: "euros-test.blogspot.jp", path: "/2017/12/test1.html", port: 443,
                query: nil, scheme: "https", userinfo: nil},
              %URI{authority: "euros-test.blogspot.jp", fragment: nil,
                host: "euros-test.blogspot.jp", path: "/2017/12/", port: 443, query: nil,
                scheme: "https", userinfo: nil}] === links
    end
  end
end

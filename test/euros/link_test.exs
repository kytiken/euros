defmodule Euros.LinkTest do
  use ExUnit.Case, async: true

  describe "Euros.Link.to_absolute/2" do
    test "href_uri is absolute path uri" do
      href_uri = URI.parse("http://example.com/path?query=foo#fragment")
      base_uri = URI.parse("http://example.com")
      result = Euros.Link.to_absolute(href_uri, base_uri)
      assert base_uri.scheme === result.scheme
      assert base_uri.host   === result.host
      assert base_uri.port   === result.port
      assert href_uri.path   === result.path
      assert href_uri.query  === result.query
      assert nil             === result.fragment
    end

    test "request_uri is absolute path uri" do
      href_uri = URI.parse("/path?query=foo#fragment")
      request_uri = URI.parse("http://example.com:8080")
      result = Euros.Link.to_absolute(href_uri, request_uri)
      assert request_uri.scheme === result.scheme
      assert request_uri.host   === result.host
      assert request_uri.port   === result.port
      assert href_uri.path      === result.path
      assert href_uri.query     === result.query
      assert nil                === result.fragment
    end

    test "request_uri is relative path uri" do
      href_uri = URI.parse("path?query=foo#fragment")
      request_uri = URI.parse("http://example.com:8080/relative_path/index.html")
      result = Euros.Link.to_absolute(href_uri, request_uri)
      assert request_uri.scheme                === result.scheme
      assert request_uri.host                  === result.host
      assert request_uri.port                  === result.port
      assert "/relative_path/#{href_uri.path}" === result.path
      assert href_uri.query                    === result.query
      assert nil                               === result.fragment
    end
  end
end

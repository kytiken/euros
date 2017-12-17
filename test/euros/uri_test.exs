defmodule Euros.URITest do
  use ExUnit.Case, async: true

  describe "Euros.URI.is_same_host/2" do
    test "return true when same host uri" do
      url = "http://example.com"
      href_uri = URI.parse("#{url}/path?query=foo#fragment")
      base_uri = URI.parse(url)
      Euros.URI.is_same_host(href_uri, base_uri)
    end

    test "return false when different host uri" do
       href_uri = URI.parse("http://a.example.com/path?query=foo#fragment")
       base_uri = URI.parse("http://b.example.com")
       Euros.URI.is_same_host(href_uri, base_uri)
    end

    test "return true when relative path uri" do
      url = "http://example.com"
      href_uri = URI.parse("/path?query=foo#fragment")
      base_uri = URI.parse(url)
      Euros.URI.is_same_host(href_uri, base_uri)
    end
  end

  describe "Euros.URI.is_relative_uri/1" do
    test "return true when relative uri" do
      uri = URI.parse("/path?query=foo#fragment")
      assert Euros.URI.is_relative_path(uri)
    end

    test "return false when absolute uri" do
      uri = URI.parse("http://example.com/path?query=foo#fragment")
      refute Euros.URI.is_relative_path(uri)
    end
  end

  describe "Euros.URI.to_base_uri/1" do
    test "parse uri" do
      base_uri = Euros.URI.to_base_uri("http://example.com:8080/path?query=foo#fragment")
      assert base_uri.scheme == "http"
      assert base_uri.host == "example.com"
      assert base_uri.port == 8080
    end

    test "delete path, query, fragment" do
      base_uri = Euros.URI.to_base_uri("http://example.com:8080/path?query=foo#fragment")
      assert base_uri.path == nil
      assert base_uri.query == nil
      assert base_uri.fragment == nil
    end
  end
end

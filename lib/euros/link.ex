defmodule Euros.Link do
  @moduledoc """
  """

  @doc """
  Return absolute uri

  ## Examples

      iex> href_uri = URI.parse("http://example.com/path?query=foo#fragment")
      %URI{authority: "example.com", fragment: "fragment", host: "example.com",
       path: "/path", port: 80, query: "query=foo", scheme: "http", userinfo: nil}
      iex> base_uri = URI.parse("http://example.com")
      %URI{authority: "example.com", fragment: nil, host: "example.com", path: nil,
       port: 80, query: nil, scheme: "http", userinfo: nil}
      iex> Euros.Link.to_absolute(href_uri, base_uri)
      %URI{authority: "example.com", fragment: nil, host: "example.com",
       path: "/path", port: 80, query: "query=foo", scheme: "http", userinfo: nil}
  """
  def to_absolute(%URI{} = href_uri, %URI{} = base_uri) do
    href_uri_without_fragment = %URI{href_uri | fragment: nil}
    if Euros.URI.is_relative_path(href_uri) do
      URI.merge(base_uri, href_uri_without_fragment)
    else
      href_uri_without_fragment
    end
  end
end

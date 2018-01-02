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
  def to_absolute(%URI{} = href_uri, %URI{} = request_uri) do
    new_uri = %URI{href_uri | fragment: nil,
                              path: Euros.URI.absolute_path(href_uri.path, request_uri.path)}

    if Euros.URI.is_relative_url(href_uri) do
      URI.merge(Euros.URI.to_base_uri(request_uri), new_uri)
    else
      new_uri
    end
  end
end

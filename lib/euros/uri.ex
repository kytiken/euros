defmodule Euros.URI do
  @moduledoc """
  Provides the function for parse uri
  """

  @doc """
  Check uri to same host

  ## Examples

      iex> a = URI.parse("http://a.example.com")
      %URI{authority: "a.example.com", fragment: nil, host: "a.example.com",
       path: nil, port: 80, query: nil, scheme: "http", userinfo: nil}
      iex> b = URI.parse("http://b.example.com")
      %URI{authority: "b.example.com", fragment: nil, host: "b.example.com",
       path: nil, port: 80, query: nil, scheme: "http", userinfo: nil}
      iex> Euros.URI.is_same_host(a, b)
      false
      iex> Euros.URI.is_same_host(a, a)
      true
  """
  def is_same_host(%URI{} = href_uri, %URI{} = base_uri) do
    href_uri.authority == base_uri.authority
  end

  @doc """
  Check uri to same host for relative uri

  ## Examples
      iex> href_uri = URI.parse("/path?query=foo#fragment")
      %URI{authority: nil, fragment: "fragment", host: nil, path: "/path", port: nil,
       query: "query=foo", scheme: nil, userinfo: nil}
      iex> base_uri = URI.parse("http://example.com")
      %URI{authority: "example.com", fragment: nil, host: "example.com",
       path: nil, port: 80, query: nil, scheme: "http", userinfo: nil}
      iex>  Euro.URI.is_same_host(href_uri, base_uri)
  """
  def is_same_host(%URI{host: nil} = _href_uri, %URI{} = _base_uri) do
    true
  end

  @doc """
  Check uri path relative or absolute

  ## Examples

      iex> Euros.URI.is_relative_path(URI.parse("/path?query=foo#fragment"))
      true
      iex> Euros.URI.is_relative_path(URI.parse("http://example.com/path?query=foo#fragment"))
      false
  """
  def is_relative_path(%URI{} = uri) do
    uri.host == nil
  end

  @doc """
  Parse url and return base_uri
  Delete path, query and fragment from url

  ## Examples

      iex>  Euro.URI.base_uri("http://example.com/path?query=foo#fragment")
      %URI{authority: "example.com", fragment: nil,
       host: "example.com", path: nil, port: 80, query: nil,
       scheme: "http", userinfo: nil}
  """
  def to_base_uri(url) do
    %URI{URI.parse(url) | path: nil, query: nil, fragment: nil}
  end
end

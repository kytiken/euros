defmodule Euros.Page do
  @moduledoc """
  Provides the function for parse a web page 
  """

  @doc """
  Get link uris from response body
  Ignore duplicate uri

  ## Example

      iex> Euros.HTTP.fetch_pages("http://example.com") |> Euros.Page.link_uris
      [%URI{authority: "www.iana.org", fragment: nil, host: "www.iana.org",
       path: "/domains/example", port: 80, query: nil, scheme: "http",
       userinfo: nil}]
  """
  def link_uris(%HTTPoison.Response{} = response) do
    base_uri = to_base_uri(response)
    response
    |> all_link_uris
    |> Enum.filter(fn(uri) -> Euros.URI.is_same_host(uri, base_uri) end)
  end

  def link_uris(%HTTPoison.Error{} = response) do
    []
  end

  defp all_link_uris(%HTTPoison.Response{} = response) do
    base_uri = to_base_uri(response)
    response.body
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.map(fn(href) -> Euros.Link.to_absolute(URI.parse(href), base_uri) end)
    |> Enum.filter(fn(uri) -> is_html(uri.path) end)
    |> Enum.uniq
  end

  defp is_html(uri_path) when uri_path != nil do
    if String.contains?(uri_path, ".") do
      String.contains?(uri_path, ".htm") || String.contains?(uri_path, ".php")
    else
      true
    end
  end

  defp is_html(uri_path) when uri_path == nil do
    true
  end

  defp to_base_uri(response) do
    response.request_url
    |> Euros.URI.to_base_uri
  end
end

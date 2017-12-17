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
    uris = all_link_uris(response)
    Enum.filter(uris, fn(uri) -> Euros.URI.is_same_host(uri, base_uri) end)
  end

  defp all_link_uris(%HTTPoison.Response{} = response) do
    a_tags = Floki.find(response.body, "a")
    hrefs = Floki.attribute(a_tags, "href")
    base_uri = to_base_uri(response)
    all_uris = Enum.map(hrefs, fn(href) ->
      Euros.Link.to_absolute(URI.parse(href), base_uri)
    end)
    Enum.uniq(all_uris)
  end

  defp to_base_uri(response) do
    response.request_url
    |> Euros.URI.to_base_uri
  end
end

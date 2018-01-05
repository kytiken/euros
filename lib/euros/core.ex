defmodule Euros.Core do
  @moduledoc """
  Provides the function for crawl web page
  """
  @default_timeout 60_000

  @doc """
  crawl web page

  ## Example

      iex> url = "https://euros-test.blogspot.jp/" 
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end)

  if set cookie

      iex> url = "https://euros-test.blogspot.jp/" 
      iex> http_option = %Euros.HTTPOption{cookie: "foo=bar;"}
      iex> option = %Euros.CrawlOption{http_option: http_option}
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option)

  if cusotm url pattern

      iex> url = "https://euros-test.blogspot.jp/" 
      iex> option = %Euros.HTTPOption{cookie: "foo=bar;"}
      iex> pattern = ~r/test1/
      iex> option = %Euros.CrawlOption{http_option: http_option, pattern: pattern}
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option, pattern)
  """
  def crawl(url, callback, option \\ %Euros.CrawlOption{}) do
    {:ok, registry_name} = Euros.CrawledRegistry.start()
    do_crawl(url, registry_name, callback, option)
  end

  defp do_crawl(url, registry_name, callback, %Euros.CrawlOption{http_option: http_option, pattern: pattern} = option) do
    url
    |> Euros.HTTP.fetch_pages(http_option)
    |> fetched_callback(callback)
    |> Euros.Page.link_uris(pattern)
    |> Enum.filter(fn(uri) -> !Euros.CrawledRegistry.exists?(registry_name, uri) end)
    |> Enum.map(fn(uri) -> crawl_task(uri, registry_name, callback, option) end)
    |> Enum.each(fn(task) -> Task.await(task, @default_timeout) end)
    :ok
  end

  defp fetched_callback(page, callback) do
    callback.(page)
    page
  end

  defp crawl_task(%URI{} = uri, registry_name, callback, option) do
    Euros.CrawledRegistry.register(registry_name, uri)
    Task.async(fn -> do_crawl(URI.to_string(uri), registry_name, callback, option) end)
  end
end

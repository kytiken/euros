defmodule Euros.Core do
  @moduledoc """
  Provides the function for crawl web page
  """
  @default_timeout 60_000

  @doc """
  crawl web page

  ## Example

      iex> url = "https://euros-test.blogspot.jp/" 
      "https://euros-test.blogspot.jp/"
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end)

  if set cookie

      iex> url = "https://euros-test.blogspot.jp/" 
      "https://euros-test.blogspot.jp/"
      iex> option = %Euros.HTTPOption{cookie: "foo=bar;"}
      %Euros.HTTPOption{cookie: "foo=bar;", recv_timeout: 60000, timeout: 60000}
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option)

  if cusotm url pattern

      iex> url = "https://euros-test.blogspot.jp/" 
      "https://euros-test.blogspot.jp/"
      iex> option = %Euros.HTTPOption{cookie: "foo=bar;"}
      %Euros.HTTPOption{cookie: "foo=bar;", recv_timeout: 60000, timeout: 60000}
      iex> pattern = ~r/test1/
      ~r/test1/
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option, pattern)
  """
  def crawl(url, callback, option \\ %Euros.HTTPOption{}, pattern \\ ~r/.*/) do
    {:ok, registry_name} = Euros.CrawledRegistry.start()
    do_crawl(url, registry_name, callback, option, pattern)
  end

  defp do_crawl(url, registry_name, callback, option, pattern) do
    url
    |> Euros.HTTP.fetch_pages(option)
    |> fetched_callback(callback)
    |> Euros.Page.link_uris(pattern)
    |> Enum.filter(fn(uri) -> !Euros.CrawledRegistry.exists?(registry_name, uri) end)
    |> Enum.map(fn(uri) -> crawl_task(uri, registry_name, callback, option, pattern) end)
    |> Enum.each(fn(task) -> Task.await(task, @default_timeout) end)
    :ok
  end

  defp fetched_callback(page, callback) do
    callback.(page)
    page
  end

  defp crawl_task(%URI{} = uri, registry_name, callback, option, pattern) do
    Euros.CrawledRegistry.register(registry_name, uri)
    Task.async(fn -> do_crawl(URI.to_string(uri), registry_name, callback, option, pattern) end)
  end
end

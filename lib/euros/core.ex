defmodule Euros.Core do
  @moduledoc """
  Provides the function for crawl web page
  """

  @doc """
  crawl web page

  ## Example

      iex> url = "https://euros-test.blogspot.jp/" 
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end)

  if set depth limit

      iex> url = "https://euros-test.blogspot.jp/" 
      iex> option = %Euros.CrawlOption{depth_limit: 2}
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option)


  if set cookie

      iex> url = "https://euros-test.blogspot.jp/" 
      iex> http_option = %Euros.HTTPOption{cookie: "foo=bar;"}
      iex> option = %Euros.CrawlOption{http_option: http_option}
      iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option)

  if custom url pattern

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

  defp do_crawl(
         url,
         registry_name,
         callback,
         %Euros.CrawlOption{http_option: http_option, pattern: pattern} = option
       ) do
    url
    |> Euros.HTTP.fetch_pages(http_option)
    |> fetched_callback(callback)
    |> Euros.Page.link_uris(pattern)
    |> Enum.filter(fn uri -> !Euros.CrawledRegistry.exists?(registry_name, uri) end)
    |> Enum.map(fn uri -> crawl_task(uri, registry_name, callback, option) end)
    |> Enum.each(fn task -> Task.await(task, crawl_task_timeout(option)) end)

    :ok
  end

  defp crawl_task_timeout(%Euros.CrawlOption{
         http_option: %Euros.HTTPOption{recv_timeout: recv_timeout, timeout: timeout}
       }) do
    recv_timeout + timeout
  end

  defp fetched_callback(page, callback) do
    callback.(page)
    page
  end

  defp crawl_task(
         %URI{} = uri,
         registry_name,
         callback,
         %Euros.CrawlOption{depth_limit: depth_limit} = option
       ) do
    Euros.CrawledRegistry.register(registry_name, uri)

    Task.async(fn ->
      unless is_too_deep(depth_limit) do
        do_crawl(URI.to_string(uri), registry_name, callback, decrement_depth_limit(option))
      end
    end)
  end

  defp is_too_deep(depth_limit) do
    !(depth_limit > 0 || depth_limit === nil)
  end

  defp decrement_depth_limit(%Euros.CrawlOption{depth_limit: depth_limit} = option)
       when depth_limit !== nil do
    %Euros.CrawlOption{option | depth_limit: depth_limit - 1}
  end

  defp decrement_depth_limit(%Euros.CrawlOption{depth_limit: nil} = option) do
    option
  end
end

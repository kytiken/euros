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
  """
  def crawl(url, callback, option \\ %Euros.HTTPOption{}) do
    registry_name = Register.Euros
    case Registry.start_link(:unique, registry_name) do
      {:ok, _}                        -> crawl(url, registry_name, callback, option)
      {:error, {:already_started, _}} -> crawl(url, registry_name, callback, option)
    end
  end

  defp crawl(url, registry_name, callback, option) do
    url
    |> Euros.HTTP.fetch_pages(option)
    |> fetched_callback(callback)
    |> Euros.Page.link_uris
    |> Enum.filter(fn(uri) -> Registry.lookup(registry_name, uri) === [] end)
    |> Enum.map(fn(uri) -> crawl_task(uri, registry_name, callback, option) end)
    |> Enum.each(fn(task) -> Task.await(task, @default_timeout) end)
    :ok
  end

  defp fetched_callback(page, callback) do
    callback.(page)
    page
  end

  defp crawl_task(%URI{} = uri, registry_name, callback, option) do
    Registry.register(registry_name, uri, :crawled)
    Task.async(fn -> crawl(URI.to_string(uri), registry_name, callback, option) end)
  end
end

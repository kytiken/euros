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
  """
  def crawl(url, callback) do
    registry_name = Register.Euros
    case Registry.start_link(:unique, registry_name) do
      {:ok, _}                        -> crawl(url, registry_name, callback)
      {:error, {:already_started, _}} -> crawl(url, registry_name, callback)
    end
    
  end

  defp crawl(url, registry_name, callback) do
    tasks = url
            |> Euros.HTTP.fetch_pages(callback)
            |> Euros.Page.link_uris
            |> Enum.filter(fn(uri) -> Registry.lookup(registry_name, uri) === [] end)
            |> Enum.map(fn(uri) -> crawl_task(uri, registry_name, callback) end)
    for task <- tasks, do: Task.await(task, @default_timeout)
    :ok
  end

  defp crawl(%URI{} = uri, registry_name, callback) do
    crawl(URI.to_string(uri), registry_name, callback)
  end

  defp crawl_task(uri, registry_name, callback) do
    Registry.register(registry_name, uri, :crawled)
    Task.async(fn -> crawl(uri, registry_name, callback) end)
  end
end

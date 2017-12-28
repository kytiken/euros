defmodule Euros.HTTP do
  @moduledoc """
  Provides the functioin for get a web page

  ## Examples

      iex> Euros.HTTP.fetch_pages("http://example.com")
      %HTTPoison.Response{body: "<!doctype html>...<html>",
      headers: [{"Cache-Control", "max-age=604800"},...{"Content-Length", "1270"}],
      request_url: "http://example.com",
      status_code: 200}
  """

  @user_agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
  @default_timeout 60_000

  @doc """
  Get a web page
  """
  def fetch_pages(url) do
    case HTTPoison.get(url, %{"User-Agent": @user_agent}, [timeout: @default_timeout, recv_timeout: @default_timeout]) do
      {:ok, response} ->
        response
      {:error, %HTTPoison.Error{id: nil, reason: :timeout}} ->
        fetch_pages(url)
      {:error, error} ->
        error
      _ ->
        IO.puts "error"
    end
  end

  @doc """
  Get a web page
  """
  def fetch_pages(url, callback) do
    response = fetch_pages(url)
    callback.(response)
    response
  end
end

defmodule Euros.CrawledRegistry do
  @moduledoc """
  Manage crawled uri

  ## Example

      iex> {:ok, registry_name} = Euros.CrawledRegistry.start()
      iex> Euros.CrawledRegistry.exists?(registry_name, URI.parse("http://example.com"))
      false
      iex> Euros.CrawledRegistry.register(registry_name, URI.parse("http://example.com"))
      iex> Euros.CrawledRegistry.exists?(registry_name, URI.parse("http://example.com"))
      true
  """
  @name_length 32

  @doc """
  Start registry
  """
  def start(name \\ generate_name()) do
    case Registry.start_link(:unique, name) do
      {:ok, _} -> {:ok, name}
      {:error, {:already_started, _}} -> {:ok, name}
    end
  end

  @doc """
  Checks for already crawled
  """
  def exists?(name, uri) do
    Registry.lookup(name, uri) !== []
  end

  @doc """
  Register uri
  """
  def register(name, uri) do
    Registry.register(name, uri, :crawled)
  end

  defp generate_name do
    @name_length
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> binary_part(0, @name_length)
    |> String.to_atom()
  end
end

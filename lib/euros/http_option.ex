defmodule Euros.HTTPOption do
  @moduledoc """
  This is Euros.HTTP option

  * `cookie` - set cookie value
  * `recv_timeout` - default value is 60000ms
  * `timeout` - default value is 60000ms

  ## Example
      iex> %Euros.HTTPOption{cookie: "foo=bar;", recv_timeout: 5000, recv_timeout: 5000}
      %Euros.HTTPOption{cookie: "foo=bar;", recv_timeout: 5000, timeout: 5000}
  """
  defstruct cookie: "", timeout: 60_000, recv_timeout: 60_000
end

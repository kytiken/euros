# Euros

Euros is a web spider framework that can spider a domain and collect useful information about the pages it visits.
It is versatile, allowing you to write your own specialized spider tasks quickly and easily.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `euros` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:euros, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
iex> url = "https://euros-test.blogspot.jp/"
iex> Euros.Core.crawl(url, fn(page) -> IO.puts(inspect(page)) end)
%HTTPoison.Response{body: "<!DOCTYPE html><html dir='ltr'><head><meta content='width=device-width, initial-scale=1' name='viewport'/><title>euros test blog</title>....
```

## License
```
Copyright (c) 2017 kytiken

Released under the MIT license
https://github.com/kytiken/euros/blob/master/LICENSE
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/euros](https://hexdocs.pm/euros).


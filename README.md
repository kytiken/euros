# Euros

Euros is a web spider framework that can spider a domain and collect useful information about the pages it visits.
It is versatile, allowing you to write your own specialized spider tasks quickly and easily.

## Installation

```elixir
def deps do
  [
    {:euros, "~> 0.2.1"}
  ]
end
```

## Usage

```elixir
iex> url = "https://euros-test.blogspot.jp/"
iex> Euros.Core.crawl(url, fn(page) -> IO.puts(inspect(page)) end)
%HTTPoison.Response{body: "<!DOCTYPE html><html dir='ltr'><head><meta content='width=device-width, initial-scale=1' name='viewport'/><title>euros test blog</title>....
```

### set cookie

```elixir
iex> url = "https://euros-test.blogspot.jp/" 
iex> http_option = %Euros.HTTPOption{cookie: "foo=bar;"}
iex> option = %Euros.CrawlOption{http_option: http_option}
iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option)
```

### cusotm url pattern

```elixir
iex> url = "https://euros-test.blogspot.jp/" 
iex> option = %Euros.HTTPOption{cookie: "foo=bar;"}
iex> pattern = ~r/test1/
iex> option = %Euros.CrawlOption{http_option: http_option, pattern: pattern}
iex> Euros.Core.crawl(url, fn(page) -> page |> inspect |> IO.puts end, option, pattern)
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


defmodule Euros.CrawlOption do
  @moduledoc """
  This is Euros.Core.crawl option

  * `http_option` - http option. `Euros.HTTPOption`
  * `pattern` - crawl url pattern regexp. default is `~r/.*/`
  * `depth_limit` - number of recusive crawl fetch page. default nil
  """
  defstruct http_option: %Euros.HTTPOption{},
            pattern: ~r/.*/,
            depth_limit: nil
end

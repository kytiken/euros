defmodule Euros.CrawlOption do
  @moduledoc """
  This is Euros.Core.crawl option

  * `http_option` - http option. `Euros.HTTPOption`
  * `pattern` - crawl url pattern regexp. default is `~r/.*/`
  """
  defstruct http_option: %Euros.HTTPOption{},
            pattern: ~r/.*/
end

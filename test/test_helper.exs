:application.start :inets

server_root = '#{Path.absname("test/sample_pages")}'
test_server_config = [
  port: 32_768,
  server_name: 'localhost',
  server_root: server_root,
  document_root: server_root,
  bind_address: {127, 0, 0, 1},
  directory_index: ['index.html']
]

{:ok, pid} = :inets.start(:httpd, test_server_config)

System.at_exit fn(_exit_status) ->
  :ok = :inets.stop(:httpd, pid)
end

ExUnit.start()

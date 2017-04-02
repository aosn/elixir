# ModulesAndFunctions-7

```elixir

iex > :io.format("~4.2f~n", [3.14])
# => 3.14
# => :ok

iex > System.get_env()
# <実行結果省略>

iex > Path.extname("dave/test.exs")
# => ".ext"

iex > System.cwd()
# => "/Volumes/home/workspace/aosn/elixir/elixir"

# JSON文字列を、Elixirのデータ構造に変換する
# 
# https://github.com/cblage/elixir-json
# {status, json_value} = JSON.decode("{\"key\": \"value\"}")

iex > System.cmd("pwd", [])
# => {"/Volumes/home/workspace/aosn/elixir/elixir\n", 0}
```
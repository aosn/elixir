IO.ANSI.formatはドキュメントによるとANSIコード返してます。

IO.putsが正常に動作してる理由はどう答えればいいのかわからんですが、以下のコードから察するに：
```
iex(1)> IO.inspect "Hello, world!"
"Hello, world!"
"Hello, world!"
iex(2)> IO.inspect IO.ANSI.format( [ "Hello, ", :inverse, :bright, "world!" ], true )
[[[[[[], "Hello, "] | "\e[7m"] | "\e[1m"], "world!"] | "\e[0m"]
[[[[[[], "Hello, "] | "\e[7m"] | "\e[1m"], "world!"] | "\e[0m"]
```
「ANSIコード」ってのが実体としてはリストなので、オーバーロードはされてるなと。
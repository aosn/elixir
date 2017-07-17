# 練習問題: ControlFlow-2

## 題

FizzBuzzについて、三つの異なる実装をm(ry

## 解

### どれが問題を最も表しているだろうか。

手続き的な問題ならcondを使ったもの。
FizzBuzzは言葉遊びのため、宣言的というより手続き的で
逐次「Fizz」、「Buzz」、「FizzBuzz」、数字を答えていくもののため
(※Elixirの良さなどは完全に失われるが)

### どれが、最もメンテナンスしやすいだろうか

ガード節・パターンマッチを使って、関数を分けたもの。
関数は増えるが、個々はテストしやすいから。

### もし、この中の一つが最も良い実装だと感じたとしたら、これからElixirのk(ry

題意を汲み取ると、ガード節とパターンマッチが良いという話の流れである(たぶん)
注意喚起として、第12章の説明にあった「10行や20行のコード」になり
if、cond、caseがある場合、書き直す方針・ルールとする。
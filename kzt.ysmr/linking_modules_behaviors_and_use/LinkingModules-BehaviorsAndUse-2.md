IO.ANSI.format�̓h�L�������g�ɂ���ANSI�R�[�h�Ԃ��Ă܂��B

IO.puts������ɓ��삵�Ă闝�R�͂ǂ�������΂����̂��킩���ł����A�ȉ��̃R�[�h����@����ɁF
```
iex(1)> IO.inspect "Hello, world!"
"Hello, world!"
"Hello, world!"
iex(2)> IO.inspect IO.ANSI.format( [ "Hello, ", :inverse, :bright, "world!" ], true )
[[[[[[], "Hello, "] | "\e[7m"] | "\e[1m"], "world!"] | "\e[0m"]
[[[[[[], "Hello, "] | "\e[7m"] | "\e[1m"], "world!"] | "\e[0m"]
```
�uANSI�R�[�h�v���Ă̂����̂Ƃ��Ă̓��X�g�Ȃ̂ŁA�I�[�o�[���[�h�͂���Ă�ȂƁB
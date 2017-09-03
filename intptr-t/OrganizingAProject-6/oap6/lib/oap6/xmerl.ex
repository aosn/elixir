defmodule Oap6.Xmerl do
  require Record

  # Record type defined by usr/local/lib/erlang/lib/xmerl-1.3.15/include/xmerl.hrl
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlElement :: record(
    :xmlElement,
    name:               atom,
    expanded_name:	    String.t | {URI,Local} | {String.t, Local},
    nsinfo:             {Prefix, Local} | [],
    namespace:          xmlNamespace,
    parents:            [{atom, integer}],
    pos:                integer,
    attributes:         [xmlAttribute],
    content:            [],
    language: 	        charlist,
    xmlbase:            charlist,
    elementdef:         :undeclared | :prolog | :external | :element
  )

  Record.defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlAttribute :: record(
    :xmlAttribute,
    name:             atom,
    expanded_name:    atom | {charlist, atom},
    nsinfo:           {Prefix, Local} | [],
    namespace:        xmlNamespace,
    parents:          [{atom, integer}],
    pos:              integer,
    language:         charlist,
    value:            iolist | atom | integer,
    normalized:       true | false
  )

  Record.defrecord :xmlNamespace, Record.extract(:xmlNamespace, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlNamespace :: record(:xmlNamespace, default: list, nodes: list)

  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlText :: record(
    :xmlText,
    parents:        [{atom, integer}],
    pos:            integer,
    language:       charlist,
    value:          iolist,
    type:           atom
  )
end
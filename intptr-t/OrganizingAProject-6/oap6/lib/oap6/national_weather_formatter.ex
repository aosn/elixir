defmodule Oap6.NationalWeatherFormatter do
  import Oap6.Xmerl

  @type xpathTrans      :: {charlist, (binary, binary -> {binary, binary})}
  @type xpathTransList  :: [xpathTrans] | [charlist]

  @spec print_observation_with_document(Oap6.Xmerl.xmlElement, xpathTransList) :: :ok
  def print_observation_with_document(document, xpaths) do
    kv_list = doc_to_key_value_list(document, xpaths)
    key_widths = withds_key_of(kv_list)
    Enum.each(kv_list, fn {k, v} -> 
      IO.puts (case String.length(k) do
        0 ->  "#{String.duplicate(" ", key_widths + 1)} #{v}"
        _ ->  "#{String.pad_leading(k, key_widths)}: #{v}"
      end)
    end)
  end

  @spec doc_to_key_value_list(Oap6.Xmerl.xmlElement, []) :: []
  def doc_to_key_value_list(_doc, []), do: []

  @spec doc_to_key_value_list(Oap6.Xmerl.xmlElement, nonempty_list(xpathTrans)) :: [{binary, binary}]
  def doc_to_key_value_list(doc, [xpath_query | rest]) do
    [query_first_text(doc, xpath_query)] ++ 
      doc_to_key_value_list(doc, rest)
  end

  @spec query_first_text(Oap6.Xmerl.xmlElement, xpathTrans) :: {binary, binary}
  def query_first_text(doc, {xpath_query, replace_fn}) do
    [element | _]   = :xmerl_xpath.string(xpath_query, doc)
    [text | _]      = xmlElement(element, :content)
    value           = xmlText(text, :value)
    key             = xmlElement(element, :name)
    {new_k, new_v}  = replace_fn.(to_string(key), to_string(value))
    {to_string(new_k), to_string(new_v)}
  end

  @spec query_first_text(Oap6.Xmerl.xmlElement, charlist) :: {binary, binary}
  def query_first_text(doc, xpath_query) do
    query_first_text(doc, {xpath_query, &({&1, &2})})
  end
  
  @doc """
  Return a list containing the maximum width of key
  ## Example
      iex> kv = [{"key1", "value1"}, {"key22", "value"}]
      iex> Oap6.NationalWeatherFormatter.withds_key_of(kv)
      5
  """
  @spec withds_key_of([{binary, binary}]) :: non_neg_integer
  def withds_key_of(kv_list) do
    for {k, _v} <- kv_list do
      k |> to_string |> String.length
    end |> Enum.max
  end
end
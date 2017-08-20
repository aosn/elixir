defmodule NationalWeatherFormatterTest do
  use ExUnit.Case

  alias Oap6.NationalWeatherFormatter, as: NWFMT

  def test_data_def_key_value_list do
    [{"c1", "1"}, {"c2", "2"}, {"maximum_length_column", "10"}]
  end

  def test_data_replaced_key_value_list do
    [{"c1", "1"}, {"c2", "5"}, {"c3", "10"}]
  end

  def test_data_xml_doc do
    {doc, _rest} = """
    <?xml version="1.0" encoding="utf-8"?>
    <test_data>
      <r1>
        <c1>1</c1><c2>2</c2>
      </r1>
      <r2>
        <maximum_length_column>10</maximum_length_column>
      </r2>
    </test_data>
    """
      |> :binary.bin_to_list
      |> :xmerl_scan.string
    
    doc
  end

  test "column_widths" do
    widths = NWFMT.withds_key_of(test_data_def_key_value_list())
    assert widths == String.length("maximum_length_column")
  end

  test "default key value" do
    query = '/test_data/r1/c1'
    kv = NWFMT.query_first_text(test_data_xml_doc(), query)
    assert kv == test_data_def_key_value_list() |> Enum.at(0)
  end

  test "xpath and translation function" do
    query = '/test_data/r1/c1'
    kv = NWFMT.query_first_text(test_data_xml_doc(), {query,
      fn _k, _v -> {"key", "value"} end
    })
    assert kv == {"key", "value"}
  end  
end
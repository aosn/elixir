defmodule Oap6.CLI do
  require Logger

  @doc """
  Entry point for mix.
  dispatch to main function.
  """
  @spec run([binary]) :: :ok | no_return
  def run(argv), do: main(argv)

  @doc """
  Enter point for escript.
  Handle the command line parsing and the dispatch to
  the various functions that showing a table the 
  `National Weather Service`
  """
  @spec main([binary]) :: :ok | no_return
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a stid(station id) of National Weather Service.
  Return a tuple of `{ stid }`, or `:help` if help was given.
  """
  @spec parse_args([binary]) :: :help | {binary}
  def parse_args(argv) do
    Logger.debug(argv)
    parse = OptionParser.parse(argv,  switches: [ help: :boolean],
                                      aliases:  [ h:    :help])
    case parse do
      { [help: true], _, _ }    -> :help    # help argument
      { _, [stid | _rest], _  } -> { stid } # 1 or more arguments
      _                         -> :help    # default
    end
  end

  @doc """
  show help document.
  """
  @spec process(:help) :: no_return
  def process(:help) do
    IO.puts """
    usage: oap6 <stid>
    """
    System.halt(0)
  end
  
  @doc """
  Display formatted information of National Weather Service on `stdout`.
  """
  @spec process({binary}) :: :ok
  def process({stid}) do
    Oap6.NationalWeatherRequests.request(stid)
    |> decode_response
    |> Oap6.NationalWeatherFormatter.print_observation_with_document(
      [
        {'/current_observation/observation_time', fn _, v -> {
          "Last Updated", String.replace(v, "Last Updated on ", "")
        } end },
        {'/current_observation/observation_time_rfc822',  fn _, v-> {"", v} end },
        {'/current_observation/location',                 fn _, v-> {"Location", v} end },
        {'/current_observation/weather',                  fn _, v-> {"Weather", v} end },
        {'/current_observation/temperature_string',       fn _, v-> {"Temperature", v} end },
        {'/current_observation/dewpoint_string',          fn _, v-> {"Dewpoint", v} end },
        {'/current_observation/relative_humidity',        fn _, v-> {"Relative Humidity", "#{v} %"} end },
        {'/current_observation/heat_index_string',        fn _, v-> {"Heat Index", v} end },
        {'/current_observation/wind_string',              fn _, v-> {"Wind", v} end },
        {'/current_observation/visibility_mi',            fn _, v-> {"Visibility", "#{v} miles"} end },
        {'/current_observation/pressure_string',          fn _, v-> {"MSL Pressure", "#{v} miles"} end },
        {'/current_observation/pressure_in',              fn _, v-> {"Altimeter", "#{v} in Hg"} end }
      ]
    )    
  end

  @doc """
  Return xmlElement.
  """
  @spec decode_response({:ok, Oap6.Xmerl.xmlElement}) :: Oap6.Xmerl.xmlElement
  def decode_response({:ok, body}), do: body
  
  @doc """
  Display error information and never return.
  """
  @spec decode_response({:error, String.t}) :: no_return
  def decode_response({:error, error}) do
    message = Floki.find(error, "#mainContainer p")
      |> Enum.at(0)
      |> Floki.text()
      |> String.trim()
    IO.puts "Error fetching from National Weather Service:\n#{message}"
    System.halt(2)
  end
end
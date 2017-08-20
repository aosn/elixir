defmodule Oap6.NationalWeatherRequests do
  require Logger

  @spec request(binary) :: {:ok, Oap6.Xmerl.xmlElement} | {:error, binary}
  def request(stid) do
    Logger.debug "Request state id=#{stid}"
    request_url(stid)
    |> HTTPoison.get
    |> handle_response
  end

  # National Oceanic and Atmospheric Administration's National Weather Service
  @noaa_url Application.get_env(:oap6, :noaa_url)

  @spec request_url(binary) :: binary
  def request_url(stid) do
    url = "#{@noaa_url}/#{stid}.xml"
    Logger.debug "URL=#{url}"
    url
  end

  @spec handle_response({:ok, HTTPoison.Response.t | HTTPoison.AsyncResponse.t}) :: {:ok, Oap6.Xmerl.xmlElement}
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.debug "Successful response"
    Logger.debug fn -> inspect(body) end
    {document, _rest} = body
      |> :binary.bin_to_list
      |> :xmerl_scan.string
    {:ok, document}
  end

  @spec handle_response({:error, HTTPoison.Error.t}) :: {:error, binary}
  def handle_response({_, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    Logger.debug fn -> inspect(body) end
    {:error, body}
  end
end
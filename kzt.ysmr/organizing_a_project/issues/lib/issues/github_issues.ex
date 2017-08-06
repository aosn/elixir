defmodule Issues.GithubIssues do
  @user_agent %{ "User-agent" => "Elixir kzt.ysmr@gmail.com" }

  def fetch( user, project ) do
    issues_url( user, project )
    |> Tesla.get( headers: @user_agent )
    |> handle_response
  end

  def issues_url( user, project ) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
    # "http://www.google.co.jp"
  end

  def handle_response( %{ status: 200, body: body  } ), do: { :ok, Poison.Parser.parse!( body ) }
  def handle_response( %{ status: _, body: body } ), do: { :error, Poison.Parser.parse!( body ) }
end

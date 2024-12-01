defmodule AoC.Problem do
  require Logger

  @doc """
  Fetch part one input for the specified year and day from AoC.
  """
  @spec input(non_neg_integer(), non_neg_integer()) ::
          {:ok, String.t()} | {:error, :request_failed}
  def input(year, day) do
    url = "https://adventofcode.com/#{year}/day/#{day}/input"
    session = get_session!()

    case Req.get(url, headers: %{cookie: "session=#{session}"}) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %Req.Response{status: status, body: body}} ->
        Logger.error("Request failed (#{inspect(status)}): #{inspect(body)}")
        {:error, :request_failed}
    end
  end

  defp get_session!() do
    System.get_env("AOC_SESSION") ||
      raise "Environment variable AOC_SESSION was not set. Get the session cookie from the AoC website and try again."
  end
end

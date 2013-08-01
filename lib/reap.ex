defmodule Reap do
  @moduledoc """
  A simple API client for the refheap (https://www.refheap.com)
  API.
  """

  @base_url "https://www.refheap.com/api"

  defp to_string(value) when is_atom(value), do: atom_to_binary value
  defp to_string(value) do
    if is_binary value do
      value
    else
      inspect value
    end
  end

  defp parse_body(resp, {:ok, body, _}) do
    case JSEX.decode body do
      {:ok, encoded} ->
        if Dict.has_key?(encoded, "error") do
          {:error, :refheap, encoded}
        else
          {:ok, encoded}
        end
      _              -> {:error, :json, resp}
    end
  end
  defp parse_body(_, {:error, {:closed, ""}}), do: {:ok, []} # There is no body
  defp parse_body(resp, _), do: resp # The world has ended

  defp extract(resp) do
    case resp do
      {:ok, _, _, client} -> parse_body resp, :hackney.body(client)
      _                   -> {:error, :http, resp}
    end
  end

  @doc """
  Make a refheap API request.
  """
  def request(method, endpoint, params // []) do
    params = lc {k, v} inlist params, do: {to_string(k), to_string(v)}
    body = if method == :post do {:form, params} else "" end
    url = if method == :post do
      @base_url <> endpoint
    else
      "#{@base_url}#{endpoint}?#{URI.encode_query(params)}"
    end
    extract :hackney.request(method, url, [{"Content-Type", "application/json"}], body)
  end

  def start do
    :hackney.start
  end
end

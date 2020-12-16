defmodule Misobo.Authentication do
  @moduledoc """
  This module takes care of authentication
  """

  @namespace Application.get_env(:misobo, MisoboWeb.Authentication)[:namespace]

  @spec generate_token(map) :: binary()
  def generate_token(params) do
    user_data = Map.take(params, [:id, :phone])
    Phoenix.Token.sign(MisoboWeb.Endpoint, @namespace, user_data)
  end

  @spec verify(nil | binary) :: {:error, :expired | :invalid | :missing} | {:ok, any}
  def verify(token) do
    Phoenix.Token.verify(MisoboWeb.Endpoint, @namespace, token, max_age: 8_640_000_000)
  end
end

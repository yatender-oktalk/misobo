defmodule Misobo.Communication.CallProvider.ExotelMock do
  @moduledoc """
  This module is the interface of the Exotel API
  """

  def connect_call(_phone1, _phone2) do
    :ok
  end
end

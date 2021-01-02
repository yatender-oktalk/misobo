defmodule Misobo.Communication.CallProvider do
  @moduledoc """
  This module provides the interface for calls
  """

  @adapter Application.get_env(:misobo, :communication)[:call]

  def connect_call(phone1, phone2) do
    @adapter.connect_call(phone1, phone2)
  end
end

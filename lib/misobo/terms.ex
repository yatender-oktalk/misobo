defmodule Misobo.Terms do
  @moduledoc """
  This module gives the terms and conditions
  """
  require EEx

  def list_terms_conditions() do
    EEx.eval_file("./lib/misobo_web/html/terms_conditions.html.eex")
  end
end

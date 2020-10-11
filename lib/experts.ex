defmodule Experts do
  @moduledoc """
  # Experts
  name
  langauge
  rating
  total_consultations
  experiance in years
  has_many(expert_categories)
  img
  consult_karma
  about
  is_enabled
  cateogry_order
  order

  # categories
  name
  about
  is_enabled
  enabled_at

  # expert_categories
  one-to-many

  # user-expert-consultations

  many-many
  """

  # expert-slots

  # config
  # default_slot_size
  # 60 minutes
  # slot start time
  # slot end time

  # expert unavailable slots
end

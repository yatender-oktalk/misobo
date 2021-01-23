defmodule Misobo.Experts do
  @moduledoc """
  The Experts context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Communication.Message
  alias Misobo.Communication.SMSProvider

  alias Misobo.Experts.Booking
  alias Misobo.Experts.ExpertCategory
  alias Misobo.Repo
  alias Misobo.TimeUtils

  @slot_duration Application.get_env(:misobo, :env)[:slot_duration]

  @notification_provider Misobo.Services.Notifications.FCMIntegration
  @doc """
  Returns the list of expert_categories.

  ## Examples

      iex> list_expert_categories()
      [%ExpertCategory{}, ...]

  """
  def list_expert_categories do
    Repo.all(ExpertCategory)
  end

  @doc """
  Gets a single expert_category.

  Raises `Ecto.NoResultsError` if the Expert category does not exist.

  ## Examples

      iex> get_expert_category!(123)
      %ExpertCategory{}

      iex> get_expert_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert_category!(id), do: Repo.get!(ExpertCategory, id)

  @doc """
  Creates a expert_category.

  ## Examples

      iex> create_expert_category(%{field: value})
      {:ok, %ExpertCategory{}}

      iex> create_expert_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert_category(attrs \\ %{}) do
    %ExpertCategory{}
    |> ExpertCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert_category.

  ## Examples

      iex> update_expert_category(expert_category, %{field: new_value})
      {:ok, %ExpertCategory{}}

      iex> update_expert_category(expert_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert_category(%ExpertCategory{} = expert_category, attrs) do
    expert_category
    |> ExpertCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert_category.

  ## Examples

      iex> delete_expert_category(expert_category)
      {:ok, %ExpertCategory{}}

      iex> delete_expert_category(expert_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert_category(%ExpertCategory{} = expert_category) do
    Repo.delete(expert_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert_category changes.

  ## Examples

      iex> change_expert_category(expert_category)
      %Ecto.Changeset{data: %ExpertCategory{}}

  """
  def change_expert_category(%ExpertCategory{} = expert_category, attrs \\ %{}) do
    ExpertCategory.changeset(expert_category, attrs)
  end

  alias Misobo.Experts.Expert

  @doc """
  Returns the list of experts.

  ## Examples

      iex> list_experts()
      [%Expert{}, ...]

  """
  def list_experts do
    query =
      from u in Expert,
        where: u.is_enabled == true

    Repo.all(query)
  end

  @doc """
  Gets a single expert.

  Raises `Ecto.NoResultsError` if the Expert does not exist.

  ## Examples

      iex> get_expert!(123)
      %Expert{}

      iex> get_expert!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert!(id), do: Repo.get!(Expert, id)

  @doc """
  Gets a single expert.

  Raises `Ecto.NoResultsError` if the Expert does not exist.

  ## Examples

      iex> get_expert(123)
      {:ok, %Expert{}}

      iex> get_expert(456)
      nil

  """
  def get_expert(id), do: Repo.get(Expert, id)

  @doc """
  Creates a expert.

  ## Examples

      iex> create_expert(%{field: value})
      {:ok, %Expert{}}

      iex> create_expert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert(attrs \\ %{}) do
    %Expert{}
    |> Expert.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert.

  ## Examples

      iex> update_expert(expert, %{field: new_value})
      {:ok, %Expert{}}

      iex> update_expert(expert, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert(%Expert{} = expert, attrs) do
    expert
    |> Expert.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert.

  ## Examples

      iex> delete_expert(expert)
      {:ok, %Expert{}}

      iex> delete_expert(expert)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert(%Expert{} = expert) do
    Repo.delete(expert)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert changes.

  ## Examples

      iex> change_expert(expert)
      %Ecto.Changeset{data: %Expert{}}

  """
  def change_expert(%Expert{} = expert, attrs \\ %{}) do
    Expert.changeset(expert, attrs)
  end

  def fetch_experts(page) do
    expert_base() |> fetch_experts_remaining(page)
  end

  def fetch_experts_remaining(query, page) do
    query
    |> order_by(asc: :order)
    |> preload(:expert_categories)
    |> Repo.paginate(page: page)
  end

  def expert_base do
    from u in Expert,
      where: u.is_enabled == true
  end

  alias Misobo.Experts.ExpertCategoryMapping

  @doc """
  Returns the list of expert_category_mappings.

  ## Examples

      iex> list_expert_category_mappings()
      [%ExpertCategoryMapping{}, ...]

  """
  def list_expert_category_mappings do
    Repo.all(ExpertCategoryMapping)
  end

  @doc """
  Gets a single expert_category_mapping.

  Raises `Ecto.NoResultsError` if the Expert category mapping does not exist.

  ## Examples

      iex> get_expert_category_mapping!(123)
      %ExpertCategoryMapping{}

      iex> get_expert_category_mapping!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert_category_mapping!(id), do: Repo.get!(ExpertCategoryMapping, id)

  @doc """
  Creates a expert_category_mapping.

  ## Examples

      iex> create_expert_category_mapping(%{field: value})
      {:ok, %ExpertCategoryMapping{}}

      iex> create_expert_category_mapping(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert_category_mapping(attrs \\ %{}) do
    %ExpertCategoryMapping{}
    |> ExpertCategoryMapping.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert_category_mapping.

  ## Examples

      iex> update_expert_category_mapping(expert_category_mapping, %{field: new_value})
      {:ok, %ExpertCategoryMapping{}}

      iex> update_expert_category_mapping(expert_category_mapping, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert_category_mapping(%ExpertCategoryMapping{} = expert_category_mapping, attrs) do
    expert_category_mapping
    |> ExpertCategoryMapping.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert_category_mapping.

  ## Examples

      iex> delete_expert_category_mapping(expert_category_mapping)
      {:ok, %ExpertCategoryMapping{}}

      iex> delete_expert_category_mapping(expert_category_mapping)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert_category_mapping(%ExpertCategoryMapping{} = expert_category_mapping) do
    Repo.delete(expert_category_mapping)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert_category_mapping changes.

  ## Examples

      iex> change_expert_category_mapping(expert_category_mapping)
      %Ecto.Changeset{data: %ExpertCategoryMapping{}}

  """
  def change_expert_category_mapping(
        %ExpertCategoryMapping{} = expert_category_mapping,
        attrs \\ %{}
      ) do
    ExpertCategoryMapping.changeset(expert_category_mapping, attrs)
  end

  def upsert_expert_expert_categories(expert, expert_categories)
      when is_list(expert_categories) do
    expert_categories =
      ExpertCategory
      |> where([expert_category], expert_category.id in ^expert_categories)
      |> Repo.all()

    resp =
      expert
      |> Expert.changeset_update_expert_categories(expert_categories)
      |> Repo.update()

    case resp do
      {:ok, _struct} ->
        {:ok, get_expert(expert.id)}

      error ->
        {:error, error}
    end
  end

  def get_experts_for_category(id, page) do
    q =
      from u in ExpertCategoryMapping,
        join: c in Expert,
        on: c.id == u.expert_id,
        where: u.expert_category_id == ^id,
        where: c.is_enabled == true,
        select: c

    Repo.paginate(q, page: page)
  end

  def get_available_slots(date, booked_slots) do
    date
    |> TimeUtils.get_all_slots_for_day()
    |> Enum.map(fn [start_time_unix, _] ->
      date = start_time_unix |> TimeUtils.unix_to_date_time()

      %{
        date: date,
        is_booked: start_time_unix in booked_slots,
        unix_time: start_time_unix
      }
    end)
  end

  def unavailable_day?(nil, _date) do
    []
  end

  def unavailable_day?(unavailable_days, date) do
    (date |> TimeUtils.get_day() |> to_string()) in String.split(unavailable_days, ",")
  end

  def get_booked_slots_for_day(expert_id, date, false) do
    {start_time_unix, end_time_unix} = TimeUtils.get_start_end_day(date)

    query =
      from u in Booking,
        where: u.expert_id == ^expert_id,
        where: u.start_time_unix >= ^start_time_unix,
        where: u.start_time_unix <= ^end_time_unix,
        select: [u.start_time_unix]

    query |> Repo.all() |> List.flatten()
  end

  def get_booked_slots_for_day(_expert_id, date, true) do
    {start_time_unix, end_time_unix} = TimeUtils.get_start_end_day(date)
    TimeUtils.all_slots(start_time_unix, end_time_unix)
  end

  def unavailable_slots_expert(expert_id) do
    %Expert{unavailable_days: unavailable_days} = get_expert(expert_id)

    case unavailable_days do
      nil -> []
      _ -> String.split(unavailable_days, ",")
    end
  end

  def mark_notification_sent_for_booking(booking_ids) do
    query =
      from u in Booking,
        where: u.id in ^booking_ids

    Repo.update_all(query,
      set: [precall_expert_notification_sent: true, precall_customer_notification_sent: true]
    )
  end

  @doc """
  Returns the list of bookings.

  ## Examples

      iex> list_bookings()
      [%Booking{}, ...]

  """
  def list_bookings do
    Repo.all(Booking)
  end

  @doc """
  Gets a single booking.

  Raises `Ecto.NoResultsError` if the Booking does not exist.

  ## Examples

      iex> get_booking!(123)
      %Booking{}

      iex> get_booking!(456)
      ** (Ecto.NoResultsError)

  """
  def get_booking!(id), do: Repo.get!(Booking, id)

  def get_booking(id), do: Repo.get(Booking, id)

  def get_booking_by(params), do: Repo.get_by(Booking, params)

  @doc """
  Creates a booking.

  ## Examples

      iex> create_booking(%{field: value})
      {:ok, %Booking{}}

      iex> create_booking(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_booking(attrs \\ %{}) do
    %Booking{}
    |> Booking.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a booking.

  ## Examples

      iex> update_booking(booking, %{field: new_value})
      {:ok, %Booking{}}

      iex> update_booking(booking, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_booking(%Booking{} = booking, attrs) do
    booking
    |> Booking.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a booking.

  ## Examples

      iex> delete_booking(booking)
      {:ok, %Booking{}}

      iex> delete_booking(booking)
      {:error, %Ecto.Changeset{}}

  """
  def delete_booking(%Booking{} = booking) do
    Repo.delete(booking)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking booking changes.

  ## Examples

      iex> change_booking(booking)
      %Ecto.Changeset{data: %Booking{}}

  """
  def change_booking(%Booking{} = booking, attrs \\ %{}) do
    Booking.changeset(booking, attrs)
  end

  def slot_available?(params), do: get_booking_by(params) == nil

  def create_expert_booking(user_id, expert_id, start_time_unix, karma) do
    end_time_unix = start_time_unix + String.to_integer(@slot_duration)
    start_time = start_time_unix |> TimeUtils.unix_to_date_time()
    end_time = end_time_unix |> TimeUtils.unix_to_date_time()

    data = %{
      end_time: end_time,
      end_time_unix: end_time_unix,
      start_time: start_time,
      start_time_unix: start_time_unix,
      expert_id: expert_id,
      user_id: user_id,
      karma: karma
    }

    {:ok, booking} = create_booking(data)
    {:ok, Repo.preload(booking, :expert)}
  end

  def user_expert_bookings(id, page) do
    q =
      from u in Booking,
        where: u.user_id == ^id,
        select: u,
        order_by: u.inserted_at,
        preload: :expert

    Repo.paginate(q, page: page)
  end

  def unrated_bookings(id) do
    q =
      from u in Booking,
        where:
          u.user_id == ^id and u.end_time < ^DateTime.utc_now() and
            fragment("is_rated is not true"),
        select: u,
        limit: 1,
        preload: :expert

    Repo.all(q)
  end

  def get_booking_between_duration(start_time, end_time) do
    q =
      from u in Booking,
        where:
          u.start_time >= ^start_time and
            u.start_time <= ^end_time and
            u.precall_expert_notification_sent != true and
            u.precall_customer_notification_sent != true,
        select: u

    Repo.all(q)
  end

  alias Misobo.Experts.Rating

  @doc """
  Returns the list of ratings.

  ## Examples

      iex> list_ratings()
      [%Rating{}, ...]

  """
  def list_ratings do
    Repo.all(Rating)
  end

  @doc """
  Gets a single rating.

  Raises `Ecto.NoResultsError` if the Rating does not exist.

  ## Examples

      iex> get_rating!(123)
      %Rating{}

      iex> get_rating!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rating!(id), do: Repo.get!(Rating, id)

  @doc """
  Creates a rating.

  ## Examples

      iex> create_rating(%{field: value})
      {:ok, %Rating{}}

      iex> create_rating(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rating(attrs \\ %{}) do
    %Rating{}
    |> Rating.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rating.

  ## Examples

      iex> update_rating(rating, %{field: new_value})
      {:ok, %Rating{}}

      iex> update_rating(rating, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rating(%Rating{} = rating, attrs) do
    rating
    |> Rating.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rating.

  ## Examples

      iex> delete_rating(rating)
      {:ok, %Rating{}}

      iex> delete_rating(rating)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rating(%Rating{} = rating) do
    Repo.delete(rating)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rating changes.

  ## Examples

      iex> change_rating(rating)
      %Ecto.Changeset{data: %Rating{}}

  """
  def change_rating(%Rating{} = rating, attrs \\ %{}) do
    Rating.changeset(rating, attrs)
  end

  def get_average_rating(expert_id) do
    query = from u in Rating, where: u.expert_id == ^expert_id
    Repo.aggregate(query, :avg, :rating)
  end

  def notify_expert_booking(nil, _start_time), do: :ok

  def notify_expert_booking(expert_phone, start_time_unix) do
    msg =
      start_time_unix
      |> Message.get_expert_booking_msg()

    expert_phone
    |> Message.add_prefix()
    |> SMSProvider.send_sms(msg)

    :ok
  end

  def notify_customer_booking(nil, phone, start_time_unix, expert_name) do
    msg = start_time_unix |> customer_booking_msg(expert_name)

    phone
    |> Message.add_prefix()
    |> SMSProvider.send_sms(msg)

    :ok
  end

  def notify_customer_booking(token, _phone, start_time_unix, expert_name) do
    msg = start_time_unix |> customer_booking_msg(expert_name)
    msg = %{heading: "Booking intimation", text: msg}

    @notification_provider.send_many_notifications([token], msg)
    :ok
  end

  defp customer_booking_msg(start_time_unix, expert_name) do
    Message.get_customer_booking_msg(start_time_unix, expert_name)
  end
end

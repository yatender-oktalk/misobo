defmodule MisoboWeb.Router do
  use MisoboWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug MisoboWeb.DbHealthPlug
  end

  pipeline :user_activated do
    plug MisoboWeb.ActivateAuthPlug
  end

  pipeline :registration_authenticated do
    plug MisoboWeb.RegistrationAuthPlug
  end

  scope "/api", MisoboWeb do
    pipe_through :api

    # Health endpoints
    get("/health", HealthController, :index)
    get("/token/:id/generate", TokenController, :generate)

    # Terms and condition
    get("/terms", TermsController, :index)

    # Registration realated APIs
    post("/registration", RegistrationController, :create)

    scope("/") do
      pipe_through :registration_authenticated

      post("/user/:user_id/verify", UserController, :verify)
      post("/user/:user_id/send_sms", UserController, :send_sms)

      scope("/") do
        pipe_through :user_activated

        get("/categories", CategoryController, :index)
        get("/experts", ExpertController, :fetch)
        get("/experts/:id", ExpertController, :show)

        get("/category_experts/:id", CategoryController, :category_experts)
        get("/expert_categories", ExpertController, :get_categories)

        put(
          "/registration/:registration_id/categories",
          CategoryController,
          :update_registration_categories
        )

        get(
          "/registration/:registration_id",
          RegistrationController,
          :show
        )

        put(
          "/registration/:registration_id/sub_categories",
          CategoryController,
          :update_registration_sub_categories
        )

        post("/user", UserController, :register_phone)
        post("/user/:user_id/bmi", UserController, :calculate_bmi)

        get("/user/:id", UserController, :index)
        put("/user/:id", UserController, :update)
        get("/user/:id/expert_bookings", UserController, :expert_bookings)
        get("/user/:id/unrated_bookings", UserController, :unrated_bookings)

        post("/expert/:id/slots", ExpertController, :expert_slots)
        post("/expert/:expert_id/book_slot", ExpertController, :book_slot)

        scope("/music") do
          get("/", MusicController, :index)
          get("/:id", MusicController, :show)
          patch("/:id/progress", MusicController, :track_user_music_progress)
        end

        get("/packs", PackController, :index)

        get("/blogs", BlogController, :index)
        get("/blogs/:id", BlogController, :show)

        post("/order", OrderController, :create)
        post("/order/capture", OrderController, :capture)

        post("/rating", RatingController, :create)

        scope("/rewards") do
          get("/", RewardController, :index)
          get("/:id", RewardController, :show)

          post("/:reward_id/redeem", RewardController, :redeem)
          get("/:user_id/redeemed", RewardController, :redeemed)
        end

        get("/token/info", TokenController, :info)
      end
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MisoboWeb.Telemetry
    end
  end
end

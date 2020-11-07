defmodule MisoboWeb.Router do
  use MisoboWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug MisoboWeb.DbHealthPlug
  end

  # pipeline :authenticated do
  #   plug MisoboWeb.AuthPlug
  # end

  pipeline :registration_authenticated do
    plug MisoboWeb.RegistrationAuthPlug
  end

  scope "/api", MisoboWeb do
    pipe_through :api

    # Health endpoints
    get("/health", HealthController, :index)

    # Registration realated APIs
    post("/registration", RegistrationController, :create)

    get("/experts", ExpertController, :fetch)
    get("/experts/:id", ExpertController, :show)

    get("/category_experts/:id", CategoryController, :category_experts)
    get("/expert_categories", ExpertController, :get_categories)

    scope("/") do
      pipe_through :registration_authenticated
      get("/categories", CategoryController, :index)

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
      post("/user/:user_id/verify", UserController, :verify)
      post("/user/:user_id/bmi", UserController, :calculate_bmi)

      get("/user/:id", UserController, :index)
      put("/user/:id", UserController, :update)

      post("/expert/:id/slots", ExpertController, :expert_slots)
      post("/expert/:expert_id/book_slot", ExpertController, :book_slot)
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

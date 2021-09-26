defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HelloWeb do
    pipe_through :api
    post "/horoscopes", ApiController, :create
    get "/horoscopes/:horoscope_id", ApiController, :get
    post "/horoscopes/:horoscope_id/:question_id", ApiController, :record_answer
  end
end

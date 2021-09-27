defmodule HelloWeb.ApiController do
  use HelloWeb, :controller

  def create(conn, _params) do
    result =
      Journey.Process.execute(Hello.HoroscopeItinerary.itinerary())
      |> HelloWeb.ApiReturnValue.from_execution()

    conn
    |> put_status(:created)
    |> json(result)
  end

  def get(conn, %{"horoscope_id" => horoscope_id}) do
    case Journey.Execution.load(horoscope_id) do
      {:error, :no_such_execution} ->
        conn |> send_resp(404, "not found")

      {:ok, execution} ->
        json(
          conn,
          HelloWeb.ApiReturnValue.from_execution(execution)
        )
    end
  end

  def record_answer(conn, %{
        "horoscope_id" => horoscope_id,
        "question_id" => question_id,
        "answer" => answer
      }) do
    {:ok, execution} =
      Journey.Execution.update_value(
        horoscope_id,
        Journey.Utilities.to_existing_atom(question_id),
        answer
      )

    json(
      conn,
      HelloWeb.ApiReturnValue.from_execution(execution)
    )
  end
end

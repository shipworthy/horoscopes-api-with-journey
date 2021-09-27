defmodule HelloWeb.ApiController do
  use HelloWeb, :controller

  def create(conn, _params) do
    result =
      Hello.HoroscopeItinerary.itinerary()
      |> Journey.Process.execute()
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
      horoscope_id
      |> Journey.Execution.update_value(
        Journey.Utilities.to_existing_atom(question_id),
        answer
      )

    json(
      conn,
      HelloWeb.ApiReturnValue.from_execution(execution)
    )
  end
end

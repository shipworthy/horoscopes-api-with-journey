defmodule HelloWeb.ApiController do
  use HelloWeb, :controller

  def create(conn, _params) do
    result = %HelloWeb.ApiReturnValue{
      horoscope_id: "123",
      next_question_id: "name"
    }

    conn
    |> put_status(:created)
    |> json(result)
  end

  def get(conn, %{"horoscope_id" => horoscope_id}) do
    case horoscope_id do
      "123" ->
        result = %HelloWeb.ApiReturnValue{
          horoscope_id: "123",
          next_question_id: "name"
        }

        conn |> json(result)

      _ ->
        conn |> put_status(404)
    end
  end

  def record_answer(conn, %{
        "horoscope_id" => horoscope_id,
        "question_id" => question_id,
        "answer" => answer
      }) do
    result = %HelloWeb.ApiReturnValue{
      horoscope_id: horoscope_id,
      next_question_id: nil,
      horoscope: "this is a great week to go do things"
    }

    conn |> json(result)
  end
end

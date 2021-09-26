defmodule HelloWeb.ApiReturnValue do
  @derive Jason.Encoder
  defstruct [:horoscope_id, :next_question_id, :horoscope, answers_so_far: []]
end

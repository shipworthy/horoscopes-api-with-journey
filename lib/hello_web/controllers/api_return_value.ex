defmodule HelloWeb.ApiReturnValue do
  @derive Jason.Encoder
  defstruct [:horoscope_id, :next_question_id, :horoscope, :status]

  def from_execution(execution) do
    horoscope =
      case(Journey.Execution.read_value(execution, :horoscope)) do
        {:computed, value} -> value
        _ -> nil
      end

    next_question =
      case Journey.Execution.get_next_available_step(execution) do
        nil -> nil
        value -> value.name
      end

    computing_step =
      execution
      |> Journey.Execution.get_ordered_steps()
      |> Enum.find(fn step ->
        step.status == :computing
      end)

    status =
      case computing_step do
        nil -> nil
        _value -> :computing
      end

    %HelloWeb.ApiReturnValue{
      horoscope_id: execution.execution_id,
      next_question_id: next_question,
      horoscope: horoscope,
      status: if(status == nil, do: :ready, else: :computing)
    }
  end
end

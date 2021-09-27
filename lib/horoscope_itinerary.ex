defmodule Hello.HoroscopeItinerary do
  def itinerary() do
    %Journey.Process{
      process_id: "horoscope computation v1",
      steps: [
        %Journey.Step{name: :first_name},
        %Journey.Step{name: :birth_month},
        %Journey.Step{name: :birth_day},
        %Journey.Step{
          name: :astrological_sign,
          # This step defers to a function for computing the astrological sign (defined elsewhere).
          func: &Hello.HoroscopeItinerary.compute_sign/1,
          # The execution of this task is dependenit on birth month and day being provided.
          blocked_by: [
            %Journey.BlockedBy{step_name: :birth_month, condition: :provided},
            %Journey.BlockedBy{step_name: :birth_day, condition: :provided}
          ]
        },
        %Journey.Step{
          name: :horoscope,
          # This step defers to a function for computing the horoscope.
          func: &Hello.HoroscopeItinerary.compute_horoscope/1,
          # The execution of this task is dependenit on first name being and astrological_sign being available.
          blocked_by: [
            %Journey.BlockedBy{step_name: :first_name, condition: :provided},
            %Journey.BlockedBy{step_name: :astrological_sign, condition: :provided}
          ]
        }
      ]
    }
  end

  @doc """
  Computes astrological sign.
  """
  def compute_sign(values) do
    # For demo purposes, pretend that this is a slow, expensive task. ; )
    :timer.sleep(200)

    {:ok, Hello.AstrologicalSign.sign(values[:birth_month].value, values[:birth_day].value)}
  end

  @doc """
  Computes horoscope.
  """
  def compute_horoscope(values) do
    # For demo purposes, pretend that this is a slow, expensive task. ; )
    :timer.sleep(300)

    horoscope =
      "#{values[:first_name].value}! You are a righteous #{values[:astrological_sign].value}! Now is the perfect week to smash the racist patriarchy."

    horoscope =
      if values[:astrological_sign].value == "taurus" do
        horoscope <> " PS Tauruses are awesome."
      else
        horoscope
      end

    {
      :ok,
      horoscope
    }
  end
end

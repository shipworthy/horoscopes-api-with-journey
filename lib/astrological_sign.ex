defmodule Hello.AstrologicalSign do
  # Compute the astrological sign, given the month and date. The upper bound of "day" is not checked.
  def sign(1, day), do: if(day < 20, do: "capricorn", else: "aquarius")
  def sign(2, day), do: if(day < 19, do: "aquarius", else: "pisces")
  def sign(3, day), do: if(day < 21, do: "pisces", else: "aries")
  def sign(4, day), do: if(day < 20, do: "aries", else: "taurus")
  def sign(5, day), do: if(day < 21, do: "taurus", else: "gemini")
  def sign(6, day), do: if(day < 21, do: "gemini", else: "cancer")
  def sign(7, day), do: if(day < 23, do: "cancer", else: "leo")
  def sign(8, day), do: if(day < 23, do: "leo", else: "virgo")
  def sign(9, day), do: if(day < 23, do: "virgo", else: "libra")
  def sign(10, day), do: if(day < 23, do: "libra", else: "scorpio")
  def sign(11, day), do: if(day < 22, do: "scorpio", else: "sagittarius")
  def sign(12, day), do: if(day < 22, do: "sagittarius", else: "capricorn")
end

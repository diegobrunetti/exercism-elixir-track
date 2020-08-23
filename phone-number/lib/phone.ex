defmodule Phone do
  defstruct length: 0,
            digits: "0000000000",
            c_code: "",
            a_code: "000",
            e_code: "000",
            s_number: "0000"

  @punctuation_pattern ~r/[[:punct:][:space:]]/u
  @phone_pattern ~r/([\d]{0,1})([2-9]{1}\d{2})([2-9]{1}\d{2})(\d{4})/
  @country_code "1"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    raw
    |> from_string()
    |> validate()
    |> select()
  end

  defp from_string(raw) do
    clean = String.replace(raw, @punctuation_pattern, "")
    phone_parts = Regex.scan(@phone_pattern, clean, capture: :all_but_first) |> List.flatten()
    create_phone(phone_parts)
  end

  defp create_phone(phone_parts) do
    if(phone_parts != []) do
      [c_code, a_code, e_code, s_number] = phone_parts
      number = "#{a_code}#{e_code}#{s_number}"

      %Phone{
        length: String.length(number),
        digits: number,
        c_code: c_code,
        a_code: a_code,
        e_code: e_code,
        s_number: s_number
      }
    else
      invalid()
    end
  end

  defp validate(%Phone{c_code: c_code} = phone) when c_code != "",
    do: if(phone.c_code == @country_code, do: phone, else: invalid())

  defp validate(%Phone{length: length}) when length < 10, do: invalid()
  defp validate(%Phone{} = phone), do: phone

  defp invalid(), do: %Phone{}

  defp select(%Phone{} = phone), do: phone.digits

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw), do: from_string(raw).a_code

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    phone = from_string(raw)
    "(#{phone.a_code}) #{phone.e_code}-#{phone.s_number}"
  end
end

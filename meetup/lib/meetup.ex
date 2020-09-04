defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """
  @week_days %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }

  @february 2

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: %Date{}
  def meetup(year, month, weekday, schedule) do
    start_day =
      case schedule do
        :teenth -> 13
        :first -> 1
        :second -> 8
        :third -> 15
        :fourth -> 22
        :last -> if(month == @february, do: 23, else: 25)
      end

    meetup_date(%Date{year: year, month: month, day: start_day}, weekday)
  end

  defp meetup_date(date, meetup_day_of_week) do
    today = Date.day_of_week(date)

    if(meetup_day_of_week == today) do
      date
    else
      add_days(date, today, @week_days[meetup_day_of_week])
    end
  end

  defp add_days(date, current, target) when current > target do
    Date.add(date, 7 - current + target)
  end

  defp add_days(date, current, target) do
    Date.add(date, target - current)
  end
end

defmodule RobotSimulator do
  defstruct direction: :north, position: {0, 0}

  defguardp is_direction(d) when d in [:north, :south, :east, :west]
  defguardp is_position(x, y) when is_integer(x) and is_integer(y)

  @directions %{
    north: %{turn_left: :west, turn_right: :east},
    south: %{turn_left: :east, turn_right: :west},
    east: %{turn_left: :north, turn_right: :south},
    west: %{turn_left: :south, turn_right: :north}
  }

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: %RobotSimulator{}
  def create(), do: %RobotSimulator{}

  def create(direction, {x, y}) when is_direction(direction) and is_position(x, y) do
    %RobotSimulator{direction: direction, position: {x, y}}
  end

  def create(direction, _position) when not is_direction(direction) do
    {:error, "invalid direction"}
  end

  def create(_direction, _invalid_position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's execute_instructionment given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: RobotSimulator, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> do_simulation(robot)
  end

  defp do_simulation(_, {:error, message}), do: {:error, message}
  defp do_simulation([], robot), do: robot

  defp do_simulation([instruction | other_instructions], robot) do
    do_simulation(other_instructions, execute_instruction(instruction, robot))
  end

  defp execute_instruction("A", %RobotSimulator{direction: direction, position: {x, y}} = robot) do
    new_position =
      case direction do
        :north -> {x, y + 1}
        :east -> {x + 1, y}
        :south -> {x, y - 1}
        :west -> {x - 1, y}
      end

    %RobotSimulator{robot | position: new_position}
  end

  defp execute_instruction("L", %RobotSimulator{direction: current_direction} = robot) do
    %RobotSimulator{robot | direction: @directions[current_direction].turn_left}
  end

  defp execute_instruction("R", %RobotSimulator{direction: current_direction} = robot) do
    %RobotSimulator{robot | direction: @directions[current_direction].turn_right}
  end

  defp execute_instruction(_invalid_instruction, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: RobotSimulator) :: atom
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: RobotSimulator) :: {integer, integer}
  def position(robot), do: robot.position
end

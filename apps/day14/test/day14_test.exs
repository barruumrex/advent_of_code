defmodule Day14Test do
  use ExUnit.Case
  doctest Day14

  test "Parsing a line returns a Reindeer" do
    reindeer = %Reindeer{name: "Vixen", speed: 19, fly_time: 7, rest_time: 124}
    line = "Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds."
    assert Day14.parse_line(line) == reindeer
  end

  test "Calculate leaderboard" do
    comet = Reindeer.new({"Comet", "14", "10", "127"})
    dancer = Reindeer.new({"Dancer", "16", "11", "162"})

    team = [comet, dancer]

    assert Day14.calc_leaderboard(team, 140, %{}) == %{comet => 1, dancer => 139}
  end
end

defmodule ReindeerTest do
  use ExUnit.Case
  doctest Reindeer

  test "During active flight time multiply time by speed" do
    reindeer = %Reindeer{}
    assert Reindeer.fly_for(reindeer, 5) == 70
  end

  test "Distance traveled stops after flight time" do
    reindeer = %Reindeer{}
    assert Reindeer.fly_for(reindeer, 15) == 140
  end

  test "Distance traveled continues after rest" do
    reindeer = %Reindeer{}
    assert Reindeer.fly_for(reindeer, 142) == 210
  end

  test "Distance traveled stops again after second flight" do
    reindeer = %Reindeer{}
    assert Reindeer.fly_for(reindeer, 200) == 280
  end
end

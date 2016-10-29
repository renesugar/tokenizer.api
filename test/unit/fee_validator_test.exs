defmodule Tokenizer.DB.Changeset.Validators.FeeTest do
  use ExUnit.Case, async: true
  alias Tokenizer.DB.Changeset.Validators.Fee

  @fees [
    {1, 5.01}, {1.5, 5.01}, {2, 5.01}, {2.5, 5.01}, {3, 5.02}, {3.5, 5.02}, {4, 5.02}, {4.5, 5.02}, {5, 5.03},
    {5.5, 5.03}, {6, 5.03}, {6.5, 5.03}, {7, 5.04}, {7.5, 5.04}, {8, 5.04}, {8.5, 5.04}, {9, 5.05}, {9.5, 5.05},
    {10, 5.05}, {10.5, 5.05}, {11, 5.06}, {11.5, 5.06}, {12, 5.06}, {12.5, 5.06}, {13, 5.07}, {13.5, 5.07}, {14, 5.07},
    {14.5, 5.07}, {15, 5.08}, {15.5, 5.08}, {16, 5.08}, {16.5, 5.08}, {17, 5.09}, {17.5, 5.09}, {18, 5.09},
    {18.5, 5.09}, {19, 5.1}, {19.5, 5.1}, {20, 5.1}, {20.5, 5.1}, {21, 5.11}, {21.5, 5.11}, {22, 5.11},
    {22.5, 5.11}, {23, 5.12}, {23.5, 5.12}, {24, 5.12}, {24.5, 5.12}, {25, 5.13}, {25.5, 5.13}, {26, 5.13},
    {26.5, 5.13}, {27, 5.14}, {27.5, 5.14}, {28, 5.14}, {28.5, 5.14}, {29, 5.15}, {29.5, 5.15}, {30, 5.15},
    {30.5, 5.15}, {31, 5.16}, {31.5, 5.16}, {32, 5.16}, {32.5, 5.16}, {33, 5.17}, {33.5, 5.17}, {34, 5.17},
    {34.5, 5.17}, {35, 5.18}, {35.5, 5.18}, {36, 5.18}, {36.5, 5.18}, {37, 5.19}, {37.5, 5.19}, {38, 5.19},
    {38.5, 5.19}, {39, 5.2}, {39.5, 5.2}, {40, 5.2}, {40.5, 5.2}, {41, 5.21}, {41.5, 5.21}, {42, 5.21},
    {42.5, 5.21}, {43, 5.22}, {43.5, 5.22}, {44, 5.22}, {44.5, 5.22}, {45, 5.23}, {45.5, 5.23}, {46, 5.23},
    {46.5, 5.23}, {47, 5.24}, {47.5, 5.24}, {48, 5.24}, {48.5, 5.24}, {49, 5.25}, {49.5, 5.25}, {50, 5.25},
    {50.5, 5.25}, {51, 5.26}, {51.5, 5.26}, {52, 5.26}, {52.5, 5.26}, {53, 5.27}, {53.5, 5.27}, {54, 5.27},
    {54.5, 5.27}, {55, 5.28}, {55.5, 5.28}, {56, 5.28}, {56.5, 5.28}, {57, 5.29}, {57.5, 5.29}, {58, 5.29},
    {58.5, 5.29}, {59, 5.3}, {59.5, 5.3}, {60, 5.3}, {60.5, 5.3}, {61, 5.31}, {61.5, 5.31}, {62, 5.31},
    {62.5, 5.31}, {63, 5.32}, {63.5, 5.32}, {64, 5.32}, {64.5, 5.32}, {65, 5.33}, {65.5, 5.33}, {66, 5.33},
    {66.5, 5.33}, {67, 5.34}, {67.5, 5.34}, {68, 5.34}, {68.5, 5.34}, {69, 5.35}, {69.5, 5.35}, {70, 5.35},
    {70.5, 5.35}, {71, 5.36}, {71.5, 5.36}, {72, 5.36}, {72.5, 5.36}, {73, 5.37}, {73.5, 5.37}, {74, 5.37},
    {74.5, 5.37}, {75, 5.38}, {75.5, 5.38}, {76, 5.38}, {76.5, 5.38}, {77, 5.39}, {77.5, 5.39}, {78, 5.39},
    {78.5, 5.39}, {79, 5.4}, {79.5, 5.4}, {80, 5.4}, {80.5, 5.4}, {81, 5.41}, {81.5, 5.41}, {82, 5.41},
    {82.5, 5.41}, {83, 5.42}, {83.5, 5.42}, {84, 5.42}, {84.5, 5.42}, {85, 5.43}, {85.5, 5.43}, {86, 5.43},
    {86.5, 5.43}, {87, 5.44}, {87.5, 5.44}, {88, 5.44}, {88.5, 5.44}, {89, 5.45}, {89.5, 5.45}, {90, 5.45},
    {90.5, 5.45}, {91, 5.46}, {91.5, 5.46}, {92, 5.46}, {92.5, 5.46}, {93, 5.47}, {93.5, 5.47}, {94, 5.47},
    {94.5, 5.47}, {95, 5.48}, {95.5, 5.48}, {96, 5.48}, {96.5, 5.48}, {97, 5.49}, {97.5, 5.49}, {98, 5.49},
    {98.5, 5.49}, {99, 5.5}, {99.5, 5.5}
  ]

  describe "calculates fee" do
    test "by fix and percent" do
      for {amount, fee} <- @fees do
        assert Decimal.equal?(Decimal.new(fee), Fee.calculate(Decimal.new(amount), 0.5, 5, 0, :infinity))
      end
    end

    test "with max" do
      assert Decimal.equal?(Decimal.new(50.5), Fee.calculate(Decimal.new(10000), 0.5, 5, 0, 50.5))
    end

    test "with min" do
      assert Decimal.equal?(Decimal.new(50.5), Fee.calculate(Decimal.new(1), 0.5, 5, 50.5, :infinity))
    end
  end
end
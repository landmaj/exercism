limit = 100

Benchee.run(%{
  "sum_of_squares_naive" => fn -> 1..limit |> Enum.map(&Integer.pow(&1, 2)) |> Enum.sum() end,
  "sum_of_squares_optimized" => fn -> limit |> Squares.sum_of_squares() end
})

Benchee.run(%{
  "square_of_sum_naive" => fn -> 1..limit |> Enum.sum() |> Integer.pow(2) end,
  "square_of_sum_optimized" => fn -> limit |> Squares.square_of_sum() end,
})

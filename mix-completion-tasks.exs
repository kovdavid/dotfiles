#! /usr/bin/env elixir

Mix.Task.load_all

Mix.Task.all_modules
|>  Enum.sort
|>  Enum.map_join(" ", fn(x) -> Mix.Task.task_name(x) end)
|>  IO.write

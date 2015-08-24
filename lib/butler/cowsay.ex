defmodule Butler.Cowsay do
  use Butler.Ears

  # maybe do something like:
  # hear("moo", state) do
  hear("moo") do
    cowsay("moo", state)
  end

  # maybe do something like:
  # respond("cowsay", message, state) do
  respond("cowsay") do
    cowsay(message, state)
  end

  defp cowsay(msg, state) do
    {response, 0} = System.cmd("cowsay", [msg])
    {:reply, {:code, response}, state}
  end

end

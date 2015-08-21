defmodule Butler.Cowsay do
  use Butler.Ears

  respond("cowsay") do
    cowsay(message)
  end

  hear("moo") do
    cowsay("moo")
  end

  defp cowsay(msg) do
    {response, 0} = System.cmd("cowsay", [msg])
    {:reply, {:code, response}}
  end

end

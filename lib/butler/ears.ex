defmodule Butler.Ears do
  use Behaviour

  defcallback listen(msg :: tuple, state :: list) :: tuple

  @doc false
  defmacro __using__(_opts) do
    quote location: :keep do
      import unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
    end
  end


  @doc false
  defmacro __before_compile__(_env) do
    quote do
      use GenEvent
      @behaviour Butler.Ears

      def handle_event(message, state) do
        case listen(message, state) do
          {:reply, reply, new_state} ->
            IO.puts reply
            {:ok, new_state}
          {:noreply, msg, new_state} ->
            IO.puts "no message"
            {:ok, new_state}
          _                          ->
            IO.puts "something wonky happened"
            {:ok, state}
        end
      end
    end
  end

  defmacro respond(command, body) do
    quote do
      def listen({unquote(command), var!(message)}, state) do
        Tuple.append(unquote(body[:do]), state)
      end
    end
  end

  defmacro hear(phrase, body) do
    quote do
      def listen({:hear, message}, state) do
        if Regex.match?(~r/#{unquote(phrase)}/, message) do
          Tuple.append(unquote(body[:do]), state)
        else
          {:noreply, message, state}
        end
      end
    end
  end
end

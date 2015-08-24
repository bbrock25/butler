defmodule Butler.Ears do

  @doc false
  defmacro __using__(_opts) do
    quote location: :keep do
      import unquote(__MODULE__)
      use GenEvent
      @before_compile unquote(__MODULE__)
    end
  end

  @doc false
  defmacro __before_compile__(_env) do
    quote do
      @doc false
      def listen(msg, state) do
        default_reply(msg, state)
      end

      @doc false
      defp default_reply(msg, state) do
        {:noreply, msg, state}
      end

      def handle_event(message, state) do
        {response, reply, new_state} = listen(message, state)

        case response do
          :reply -> IO.puts elem(reply, 1)
          :noreply -> IO.puts "No reply for: #{elem(reply, 1)}"
          _ -> IO.puts "Something wonky happened..."
        end

        {:ok, new_state}
      end

    end
  end

  defmacro respond(command, body) do
    quote do
      def listen({unquote(command), var!(message)}, var!(state)) do
        unquote(body[:do])
      end
    end
  end

  defmacro hear(phrase, body) do
    quote do
      def listen({:hear, message}, var!(state)) do
        if Regex.match?(~r/#{unquote(phrase)}/, message) do
          unquote(body[:do])
        else
          {:noreply, message, var!(state)}
        end
      end
    end
  end
end

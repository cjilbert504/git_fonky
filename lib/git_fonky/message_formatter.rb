module GitFonky
  class MessageFormatter
    def message_with_border(**params)
      border = calculate_border_for(params[:msg], params.delete(:border_char) { "*" })
      output_border_and_msg(border: border, **params)
    end

    private

    def calculate_border_for(msg, border_char)
      border_char * (msg.length + 20)
    end

    def output_border_and_msg(border:, msg:, sub_msg: nil, io_stream: STDERR, warn: true)
      io_stream.puts border
      io_stream.puts warning_header.center(border.length) if warn
      io_stream.puts msg.center(border.length)
      io_stream.puts sub_msg.center(border.length) if sub_msg
      io_stream.puts border
    end

    def warning_header
      "WARNING"
    end
  end
end

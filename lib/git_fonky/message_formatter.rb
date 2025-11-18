# frozen_string_literal: true

module GitFonky
  class MessageFormatter
    def output_message(msg, heading: false, warning: true)
      warn build_message(msg, heading: heading, warning: warning)
    end

    private

    def warning_header
      "WARNING: ".blink
    end

    def warning_footer
      " Moving on to next repo."
    end

    def build_message(msg, heading:, warning:)
      if warning
        (warning_header + msg + warning_footer).yellow
      elsif heading
        msg.underline
      else
        msg.green
      end
    end
  end
end

module GitFonky
  class Reporter
    attr_reader :repo_dir

    def initialize(repo_dir)
      @repo_dir = repo_dir
    end

    def announce_update
      msg = "Updating -> #{repo_dir.dirname} | #{repo_dir.branch} branch "
      border = calculate_border_for("=", msg)

      output_border_and_msg(border, msg, warn: false)
    end

    def invalid_branch_msg
      msg = "You are not on the main/master branch. Please checkout the main/master branch and try again."
      sub_msg = "-----> skipping #{repo_dir.dirname} | #{repo_dir.branch} branch <-----"
      border = calculate_border_for("*", msg)

      output_border_and_msg(border, msg, sub_msg)
    end

    private

    def calculate_border_for(border_char, msg)
      border_char * (msg.length + 20)
    end

    def output_border_and_msg(border, msg, sub_msg = nil, warn: true)
      puts border
      puts warning_header.center(border.length) if warn
      puts msg.center(border.length)
      puts sub_msg.center(border.length) if sub_msg
      puts border
    end

    def warning_header
      "WARNING"
    end
  end
end

module GitFonky
  class Branch
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def valid?(pattern = /(main|master)/)
      name.match?(pattern)
    end
  end
end

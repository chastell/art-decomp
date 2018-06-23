module ArtDecomp
  class B
    def self.[](*ints)
      ints.inject(0) { |int, elem| int | 1 << elem }
    end
  end
end

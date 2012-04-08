module ArtDecomp module CoreExtensions module Enumerable
  def pairs
    to_a.combination 2
  end
end end end

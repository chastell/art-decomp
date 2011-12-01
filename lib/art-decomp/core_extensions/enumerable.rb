module ArtDecomp module CoreExtensions::Enumerable
  def pairs
    to_a.combination 2
  end
end end

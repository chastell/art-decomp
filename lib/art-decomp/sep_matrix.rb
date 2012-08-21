module ArtDecomp class SepMatrix
  def initialize matrix
    @matrix = matrix
  end

  def seps
    (0...@matrix.size).flat_map do |row|
      (0...@matrix.size).map do |col|
        Sep[row, col] unless @matrix[row][col].zero?
      end
    end.compact.to_set
  end
end end

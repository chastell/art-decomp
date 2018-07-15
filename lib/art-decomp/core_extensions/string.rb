module ArtDecomp
  module CoreExtensions
    module String
      def dc_expand(columns = 0...size) # rubocop:disable AbcSize
        return [self] unless include? ArtDecomp::DontCare.to_s

        offsets = columns.sort
        i = index ArtDecomp::DontCare.to_s, offsets.shift until columns.include? i or offsets.empty?
        return [self] unless columns.include? i

        zero = dup.extend CoreExtensions::String
        one  = dup.extend CoreExtensions::String
        zero[i] = '0'
        one[i]  = '1'
        [zero.dc_expand(columns), one.dc_expand(columns)].flatten
      end
    end
  end
end

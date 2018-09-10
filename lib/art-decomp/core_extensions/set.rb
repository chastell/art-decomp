module ArtDecomp
  module CoreExtensions
    module Set
      def r_adm(int) # rubocop:disable AbcSize, MethodLength
        seps = select { |sep| int & sep == sep }
        subblocks = ::Set[]
        int.bits.each do |elem|
          bit = 1 << elem
          subblock = subblocks.find do |sb|
            seps.none? { |sep| (sb | bit) & sep == sep }
          end || 0
          subblocks.delete subblock
          subblocks << (subblock | bit)
        end
        subblocks.size.log2_ceil
      end
    end
  end
end

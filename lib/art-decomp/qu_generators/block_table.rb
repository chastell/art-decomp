module ArtDecomp
  module QuGenerators
    class BlockTable
      def ==(other)
        self.class == other.class
      end

      def blankets(fsm, u, _v) # rubocop:disable AbcSize, MethodLength
        @seps   = fsm.beta_f.seps
        @rows   = fsm.beta_q.ints.dup
        @cols   = fsm.beta_x(u).ints
        @r_adms = {}
        Enumerator.new do |yielder|
          fold_matching!
          yielder.yield Blanket.new @rows
          while @rows.size > 1
            fold!
            yielder.yield Blanket.new @rows
          end
        end
      end

      private

      def fold! # rubocop:disable AbcSize, MethodLength
        pins = @rows.size.log2_ceil
        until @rows.size.log2_ceil < pins
          @rows.pairs.each do |a, b|
            @r_adms[Set[a, b]] ||= @cols.map do |col|
              @seps.r_adm((a | b) & col)
            end.max
          end
          a, b = *@r_adms.min_by { |_key, val| val }.first
          @r_adms.delete_if { |key, _val| key.include? a or key.include? b }
          @rows.subtract [a, b]
          @rows.add a|b
        end
      end

      def fold_matching!
        loop do
          a, b = *@rows.pairs.find do |r1, r2|
            @cols.all? { |col| (r1 & col).zero? or (r2 & col).zero? }
          end
          break unless a and b
          @rows.subtract [a, b]
          @rows.add a|b
        end
      end
    end
  end
end

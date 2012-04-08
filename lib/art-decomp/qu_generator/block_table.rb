module ArtDecomp module QuGenerator class BlockTable
  def blankets fsm, u, v
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

  def fold!
    pins = @rows.size.log2_ceil
    until @rows.size.log2_ceil < pins
      @rows.pairs.each do |a, b|
        @r_adms[Set[a, b]] ||= @cols.map { |col| @seps.r_adm((a | b) & col) }.max
      end
      a, b = *@r_adms.min_by { |key, val| val }.first
      @r_adms.delete_if { |key, val| key.include? a or key.include? b }
      @rows.subtract [a, b]
      @rows.add a|b
    end
  end

  def fold_matching!
    loop do
      a, b = *@rows.pairs.find { |r1, r2| @cols.all? { |col| (r1 & col).zero? or (r2 & col).zero? } }
      break unless a and b
      @rows.subtract [a, b]
      @rows.add a|b
    end
  end
end end end

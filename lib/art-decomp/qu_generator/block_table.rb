module ArtDecomp::QuGenerator class BlockTable

  def initialize fsm, archs
    @fsm  = fsm
    @seps = fsm.beta_f.separations
  end

  def each u, v
    @rows   = @fsm.beta_q.ints.dup
    @cols   = @fsm.beta_x(u).ints
    @r_adms = {}
    fold_matching
    yield Blanket.new @rows
    while @rows.size > 1
      fold
      yield Blanket.new @rows
    end
  end

  private

  def fold
    pins = @rows.size.log2_ceil
    until @rows.size.log2_ceil < pins
      @rows.every_pair do |a, b|
        @r_adms[Set[a, b]] ||= @cols.map { |col| @seps.r_adm((a | b) & col) }.max
      end
      a, b = *@r_adms.min_by { |key, val| val }.first
      @r_adms.delete_if { |key, val| key.include? a or key.include? b }
      @rows.subtract [a, b]
      @rows << (a | b)
    end
  end

  def fold_matching
    begin
      found = false
      @rows.every_pair do |a, b|
        if @cols.all? { |col| (a & col).zero? or (b & col).zero? }
          @rows.subtract [a, b]
          @rows << (a | b)
          found = true
          break
        end
      end
    end while found
  end

end end

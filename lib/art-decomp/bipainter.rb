module ArtDecomp class Bipainter

  def initialize beta_q, beta_v, seps
    @beta_q, @beta_v = beta_q, beta_v
    @qv_colours = {}
    @g_colours  = {}
    @qv_forbidden = Hash.new { |h, k| h[k] = Set[] }
    @g_forbidden  = Hash.new { |h, k| h[k] = Set[] }
    qv_seps = seps - beta_v.seps
    @beta_v.ints.pairs.each do |a, b|
      (a & b).bits.each do |bit|
        seps.each do |sep|
          qv_seps += sep.bits.map { |b| Sep[b, bit] } if (a | b) & sep == sep
        end
      end
    end
    @qv_graph = Graph.new beta_q,          qv_seps
    @g_graph  = Graph.new beta_q * beta_v, seps
    puts
    puts '___ BIPAINTER ___'
    puts "beta_q: #{@beta_q.inspect}"
    puts "beta_v: #{@beta_v.inspect}"
    puts "qv_graph.vertices: #{@qv_graph.vertices.map(&:bits)}"
    puts "qv_graph.edges: #{@qv_graph.edges.map{|e| e.map(&:bits)}}"
    puts "qv_graph.seps: #{qv_seps.map(&:bits)}"
    puts "g_graph.vertices: #{@g_graph.vertices.map(&:bits)}"
    puts "g_graph.edges: #{@g_graph.edges.map{|e| e.map(&:bits)}}"
    puts "g_graph.seps: #{seps.map(&:bits)}"
    puts '^^^ BIPAINTER ^^^'
    puts
  end

  def blankets
    $stack = ''
    colour_next_vertex! until painted?
    qv_blocks = Hash.new 0
    g_blocks  = Hash.new 0
    @qv_colours.each { |vertex, colour| qv_blocks[colour] |= vertex }
    @g_colours.each  { |vertex, colour| g_blocks[colour]  |= vertex }
    return [Blanket.new(qv_blocks.values), Blanket.new(g_blocks.values)]
  end

  private

  def backup!
    @g_forbidden.default  = nil
    @qv_forbidden.default = nil
    @backup = {
      :g_colours    => Marshal.dump(@g_colours),
      :g_forbidden  => Marshal.dump(@g_forbidden),
      :qv_colours   => Marshal.dump(@qv_colours),
      :qv_forbidden => Marshal.dump(@qv_forbidden),
    }
    @g_forbidden.default_proc  = proc { |h, k| h[k] = Set[] }
    @qv_forbidden.default_proc = proc { |h, k| h[k] = Set[] }
  end

  def restore!
    @g_colours    = Marshal.load(@backup[:g_colours])
    @g_forbidden  = Marshal.load(@backup[:g_forbidden])
    @qv_colours   = Marshal.load(@backup[:qv_colours])
    @qv_forbidden = Marshal.load(@backup[:qv_forbidden])
    @g_forbidden.default_proc  = proc { |h, k| h[k] = Set[] }
    @qv_forbidden.default_proc = proc { |h, k| h[k] = Set[] }
  end

  def colour_g_vertex! g_vertex
    $stack << '  '
    begin
      backup!
      p $stack + "G #{g_vertex.bits}…"
      colour = :a
      colour = colour.next while @g_forbidden[g_vertex].include? colour
      colour_g! g_vertex, colour
    rescue PaintingError
      p $stack + "PaintingError G #{g_vertex.bits}/#{colour} caught"
      restore!
      forbid_g! g_vertex, colour
      retry
    end
    p $stack + "…G #{g_vertex.bits} coloured"
    $stack.chop!.chop!
  end

# def colour_g_vertex_with! g_vertex, colour
#   $stack << '  '
#   p $stack + "G #{g_vertex.bits} ← #{colour}…"
#   # FIXME: raise a custom exception
#   raise  if @g_colours[g_vertex] and @g_colours[g_vertex] != colour
#   raise  if @g_forbidden[g_vertex].include? colour
#   p $stack + "…already coloured" and $stack.chop!.chop! and return if @g_colours[g_vertex]
#   @g_colours[g_vertex] = colour
#   @g_graph.adjacent(g_vertex).each { |adj| forbid_g_colour! adj, colour }
#   trans_adjacent(g_vertex).each { |adj| colour_g_vertex_with! adj, colour }
#   p $stack + "…G #{g_vertex.bits} = #{colour}"
#   $stack.chop!.chop!
# end

  def colour_next_vertex!
    p 'colouring next vertex pair…'
    # FIXME: consider colouring G graph’s vertex first
    # FIXME: consider other vertex selection algorithms
    qv_vertex = (@qv_graph.vertices - @qv_colours.keys).sort_by { |v| [-@qv_forbidden[v].size, -@qv_graph.degree(v)] }.first
    colour_qv_vertex! qv_vertex if qv_vertex
    g_vertex = (@g_graph.vertices - @g_colours.keys).sort_by { |v| [-@g_forbidden[v].size, -@g_graph.degree(v)] }.first
    colour_g_vertex! g_vertex if g_vertex
    p '…next vertex pair coloured'
  end

  def colour_qv_vertex! qv_vertex
    $stack << '  '
    begin
      p $stack + "Qv #{qv_vertex.bits}…"
      backup!
      colour = :a
      colour = colour.next while @qv_forbidden[qv_vertex].include? colour
      colour_qv! qv_vertex, colour
    rescue PaintingError
      p $stack + "PaintingError Qv #{qv_vertex.bits}/#{colour} caught"
      restore!
      forbid_qv! qv_vertex, colour
      retry
    end
    p $stack + "…Qv #{qv_vertex.bits} coloured"
    $stack.chop!.chop!
  end

  def forbid_g! g_vertex, colour
    $stack << '  '
    p $stack + "G #{g_vertex.bits} × #{colour}…"
    p $stack + "…already forbidden" and $stack.chop!.chop! and return if @g_forbidden[g_vertex].include? colour
    raise PaintingError if colour == @g_colours[g_vertex]
    @g_forbidden[g_vertex] << colour
    siblings_of(g_vertex).each { |sibling| forbid_g! sibling, colour }
    p $stack + "…G #{g_vertex.bits} ≠ #{colour}"
    $stack.chop!.chop!
  end

  def forbid_qv! qv_vertex, colour
    $stack << '  '
    p $stack + "Qv #{qv_vertex.bits} × #{colour}…"
    p $stack + "…already forbidden" and $stack.chop!.chop! and return if @qv_forbidden[qv_vertex].include? colour
    raise PaintingError if colour == @qv_colours[qv_vertex]
    @qv_forbidden[qv_vertex] << colour
    p $stack + "…Qv #{qv_vertex.bits} ≠ #{colour}"
    $stack.chop!.chop!
  end

  def colour_g! g_vertex, colour
    raise if colour == :m
    $stack << '  '
    p $stack + "G #{g_vertex.bits} ← #{colour}…"
    p $stack + "…already coloured" and $stack.chop!.chop! and return if @g_colours[g_vertex] == colour
    raise PaintingError if @g_colours[g_vertex] and @g_colours[g_vertex] != colour
    raise PaintingError if @g_forbidden[g_vertex].include? colour
    @g_colours[g_vertex] = colour
    @g_graph.adjacent(g_vertex).each { |adjacent| forbid_g! adjacent, colour }
    siblings_of(g_vertex).each { |sibling| colour_g! sibling, colour }
    p $stack + "…G #{g_vertex.bits} = #{colour}"
    $stack.chop!.chop!
  end

  def colour_qv! qv_vertex, colour
    $stack << '  '
    p $stack + "Qv #{qv_vertex.bits} ← #{colour}…"
    p $stack + "…already coloured" and $stack.chop!.chop! and return if @qv_colours[qv_vertex] == colour
    raise PaintingError if @qv_colours[qv_vertex] and @qv_colours[qv_vertex] != colour
    raise PaintingError if @qv_forbidden[qv_vertex].include? colour
    @qv_colours[qv_vertex] = colour
    @qv_graph.adjacent(qv_vertex).each { |adjacent| forbid_qv! adjacent, colour }

    if @qv_graph.vertices.any? { |qv| @qv_colours[qv] == colour and qv != qv_vertex }
      @g_graph.vertices.select { |g| g & qv_vertex != 0 }.each do |g_vertex|
        siblings_of(g_vertex).each { |sibling| sync_colours g_vertex, sibling }
      end
    end

    p $stack + "…Qv #{qv_vertex.bits} = #{colour}"
    $stack.chop!.chop!
  end

  def siblings_of g_vertex
    # FIXME: consider iterating over @g_graph’s vertices first (thus, only once)
    siblings = Set[]
    @qv_graph.vertices.select { |qv| qv & g_vertex != 0 and @qv_colours[qv] }.each do |q_parent|
      @beta_v.ints.select { |v| v & g_vertex != 0 }.each do |v_parent|
        @qv_graph.vertices.select { |qv| @qv_colours[qv] == @qv_colours[q_parent] and qv != q_parent }.each do |qv|
          siblings += @g_graph.vertices.select { |g| g & qv != 0 and g & v_parent != 0 }
        end
      end
    end
    p $stack + "siblings of #{g_vertex.bits} are #{siblings.map(&:bits)}"
    siblings
  end

  def sync_colours v1, v2
    p $stack + "syncing #{v1.bits} and #{v2.bits}"
    (@g_forbidden[v1] - @g_forbidden[v2]).each { |col| forbid_g! v2, col }
    (@g_forbidden[v2] - @g_forbidden[v1]).each { |col| forbid_g! v1, col }
    if    @g_colours[v1] then colour_g! v2, @g_colours[v1]
    elsif @g_colours[v2] then colour_g! v1, @g_colours[v2]
    end
  end


# def colour_qv_vertex_with! qv_vertex, colour
#   $stack << '  '
#   p $stack + "Qv #{qv_vertex.bits} ← #{colour}…"
#   # FIXME: raise a custom exception
#   raise  if @qv_colours[qv_vertex] and @qv_colours[qv_vertex] != colour
#   raise  if @qv_forbidden[qv_vertex].include? colour
#   p $stack + "…already coloured" and $stack.chop!.chop! and return if @qv_colours[qv_vertex]
#   @qv_colours[qv_vertex] = colour
#   # FIXME: maybe redundant
#   @qv_graph.adjacent(qv_vertex).each { |adj| forbid_qv_colour! adj, colour }
#   # FIXME: verify and simplify the below
#   @g_graph.vertices.select { |g| qv_vertex & g == g }.each do |g_vertex|
#     v_parent = @beta_v.ints.find { |v| v & g_vertex == g_vertex }
#     @g_graph.adjacent(g_vertex).select { |g| v_parent & g == g and qv_vertex & g != g }.each do |neighbour|
#       q_parent = @beta_q.ints.find { |q| q & neighbour == neighbour }
#       forbid_qv_colour! q_parent, colour
#     end
#     trans_adjacent(g_vertex).each do |clansman|
#       # FIXME: factor out this whole block into sync_colours(g_vertex, clansman)
#       (@g_forbidden[g_vertex] - @g_forbidden[clansman]).each do |col|
#         forbid_g_colour! clansman, col
#       end
#       (@g_forbidden[clansman] - @g_forbidden[g_vertex]).each do |col|
#         forbid_g_colour! g_vertex, col
#       end
#       case
#       when @g_colours[g_vertex] then colour_g_vertex_with! clansman, @g_colours[g_vertex]
#       when @g_colours[clansman] then colour_g_vertex_with! g_vertex, @g_colours[clansman]
#       end
#     end
#   end
#   p $stack + "…Qv #{qv_vertex.bits} = #{colour}"
#   $stack.chop!.chop!
# end

# def forbid_g_colour! g_vertex, colour
#   $stack << '  '
#   p $stack + "G #{g_vertex.bits} × #{colour}…"
#   raise PaintingError if colour == @g_colours[g_vertex]
#   p $stack + "…already forbidden" and $stack.chop!.chop! and return if @g_forbidden[g_vertex].include? colour
#   @g_forbidden[g_vertex] << colour
#   trans_adjacent(g_vertex).each { |adj| forbid_g_colour! adj, colour }
#   p $stack + "…G #{g_vertex.bits} ≠ #{colour}"
#   $stack.chop!.chop!
# end

# def forbid_qv_colour! qv_vertex, colour
#   $stack << '  '
#   p $stack + "Qv #{qv_vertex.bits} × #{colour}…"
#   # FIXME: raise a custom exception
#   raise  if colour == @qv_colours[qv_vertex]
#   p $stack + "…already forbidden" and $stack.chop!.chop! and return if @qv_forbidden[qv_vertex].include? colour
#   @qv_forbidden[qv_vertex] << colour
#   p $stack + "…Qv #{qv_vertex.bits} ≠ #{colour}"
#   $stack.chop!.chop!
# end

  def painted?
    @qv_graph.vertices == @qv_colours.keys.to_set and @g_graph.vertices == @g_colours.keys.to_set
  end

# def trans_adjacent g_vertex
#   # FIXME: consider the case of multiple parents
#   q_parent = @beta_q.ints.find { |q| q & g_vertex == g_vertex }
#   v_parent = @beta_v.ints.find { |v| v & g_vertex == g_vertex }
#   return [] unless @qv_colours[q_parent]
#   q_parents = @qv_colours.select { |q, colour| colour == @qv_colours[q_parent] }.keys
#   @g_graph.vertices.select { |g| v_parent & g == g }.select { |g| q_parents.any? { |q| q & g == g } } - [g_vertex]
# end

end end

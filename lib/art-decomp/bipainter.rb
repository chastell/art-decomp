module ArtDecomp class Bipainter

  def initialize beta_q, beta_v, seps
    @beta_q, @beta_v = beta_q, beta_v
    @qv_colours = {}
    @g_colours  = {}
    @qv_forbidden = Hash.new { |h, k| h[k] = Set[] }
    @g_forbidden  = Hash.new { |h, k| h[k] = Set[] }
    @qv_graph = Graph.new beta_q,          seps - beta_v.seps
    @g_graph  = Graph.new beta_q * beta_v, seps
  end

  def blankets
    colour_next_vertex! until painted?
    qv_blocks = Hash.new 0
    g_blocks  = Hash.new 0
    @qv_colours.each { |vertex, colour| qv_blocks[colour] |= vertex }
    @g_colours.each  { |vertex, colour| g_blocks[colour]  |= vertex }
    return [Blanket.new(qv_blocks.values), Blanket.new(g_blocks.values)]
  end

  private

  def colour_g_vertex! g_vertex
    colour = :a
    colour = colour.next while @g_forbidden[g_vertex].include? colour
    # FIXME: create backup, rescue a painting exception and forbid colour
    colour_g_vertex_with! g_vertex, colour
  end

  def colour_g_vertex_with! g_vertex, colour
    # FIXME: raise a custom exception
    raise  if @g_colours[g_vertex] and @g_colours[g_vertex] != colour
    raise  if @g_forbidden[g_vertex].include? colour
    return if @g_colours[g_vertex]
    @g_colours[g_vertex] = colour
    @g_graph.adjacent(g_vertex).each { |adj| forbid_g_colour! adj, colour }
    trans_adjacent(g_vertex).each { |adj| colour_g_vertex_with! adj, colour }
  end

  def colour_next_vertex!
    qv_vertex = (@qv_graph.vertices - @qv_colours.keys).sort_by { |v| [-@qv_forbidden[v].size, -@qv_graph.degree(v)] }.first
    colour_qv_vertex! qv_vertex if qv_vertex
    g_vertex = (@g_graph.vertices - @g_colours.keys).sort_by { |v| [-@g_forbidden[v].size, -@g_graph.degree(v)] }.first
    colour_g_vertex! g_vertex if g_vertex
  end

  def colour_qv_vertex! qv_vertex
    colour = :a
    colour = colour.next while @qv_forbidden[qv_vertex].include? colour
    # FIXME: create backup, rescue a painting exception and forbid colour
    colour_qv_vertex_with! qv_vertex, colour
    @qv_graph.adjacent(qv_vertex).each { |adj| forbid_qv_colour! adj, colour }
  end

  def colour_qv_vertex_with! qv_vertex, colour
    # FIXME: raise a custom exception
    raise  if @qv_colours[qv_vertex] and @qv_colours[qv_vertex] != colour
    raise  if @qv_forbidden[qv_vertex].include? colour
    return if @qv_colours[qv_vertex]
    @qv_colours[qv_vertex] = colour
    # FIXME: verify and simplify the below
    @g_graph.vertices.select { |g| qv_vertex & g == g }.each do |g_vertex|
      v_parent = @beta_v.ints.find { |v| v & g_vertex == g_vertex }
      @g_graph.adjacent(g_vertex).select { |g| v_parent & g == g and qv_vertex & g != g }.each do |neighbour|
        q_parent = @beta_q.ints.find { |q| q & neighbour == neighbour }
        forbid_qv_colour! q_parent, colour
      end
      trans_adjacent(g_vertex).each do |clansman|
        (@g_forbidden[g_vertex] - @g_forbidden[clansman]).each do |colour|
          forbid_g_colour! clansman, colour
        end
        (@g_forbidden[clansman] - @g_forbidden[g_vertex]).each do |colour|
          forbid_g_colour! g_vertex, colour
        end
        case
        when @g_colours[g_vertex] then colour_g_vertex_with! clansman, @g_colours[g_vertex]
        when @g_colours[clansman] then colour_g_vertex_with! g_vertex, @g_colours[clansman]
        end
      end
    end
  end

  def forbid_g_colour! g_vertex, colour
    # FIXME: raise a custom exception
    raise  if colour == @g_colours[g_vertex]
    return if @g_forbidden[g_vertex].include? colour
    @g_forbidden[g_vertex] << colour
    trans_adjacent(g_vertex).each { |adj| forbid_g_colour! adj, colour }
  end

  def forbid_qv_colour! qv_vertex, colour
    # FIXME: raise a custom exception
    raise  if colour == @qv_colours[qv_vertex]
    return if @qv_forbidden[qv_vertex].include? colour
    @qv_forbidden[qv_vertex] << colour
  end

  def painted?
    @qv_graph.vertices == @qv_colours.keys.to_set and @g_graph.vertices == @g_colours.keys.to_set
  end

  def trans_adjacent g_vertex
    # FIXME: consider the case of multiple parents
    q_parent = @beta_q.ints.find { |q| q & g_vertex == g_vertex }
    v_parent = @beta_v.ints.find { |v| v & g_vertex == g_vertex }
    return [] unless @qv_colours[q_parent]
    q_parents = @qv_colours.select { |q, colour| colour == @qv_colours[q_parent] }.keys
    @g_graph.vertices.select { |g| v_parent & g == g }.select { |g| q_parents.any? { |q| q & g == g } } - [g_vertex]
  end

end end

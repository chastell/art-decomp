module ArtDecomp
  class Bipainter
    def initialize(beta_q, beta_v, seps)
      raise 'non-disjoint beta_v' unless beta_v.ints.pairs.all? { |a, b| (a & b).zero? }
      @beta_v = beta_v
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
      [Blanket.new(qv_blocks.values), Blanket.new(g_blocks.values)]
    end

    private

    def backup!
      @g_forbidden.default  = nil
      @qv_forbidden.default = nil
      @backup = {
        g_colours:    Marshal.dump(@g_colours),
        g_forbidden:  Marshal.dump(@g_forbidden),
        qv_colours:   Marshal.dump(@qv_colours),
        qv_forbidden: Marshal.dump(@qv_forbidden),
      }
      @g_forbidden.default_proc  = proc { |h, k| h[k] = Set[] }
      @qv_forbidden.default_proc = proc { |h, k| h[k] = Set[] }
    end

    def colour_g!(g_vertex, colour)
      return if @g_colours[g_vertex] == colour
      raise PaintingError if @g_colours[g_vertex] and @g_colours[g_vertex] != colour
      raise PaintingError if @g_forbidden[g_vertex].include? colour
      @g_colours[g_vertex] = colour
      @g_graph.adjacent(g_vertex).each { |adjacent| forbid_g! adjacent, colour }
      siblings_of(g_vertex).each { |sibling| colour_g! sibling, colour }
    end

    def colour_g_vertex!(g_vertex)
      backup!
      colour = :a
      colour = colour.next while @g_forbidden[g_vertex].include? colour
      colour_g! g_vertex, colour
    rescue PaintingError
      restore!
      forbid_g! g_vertex, colour
      retry
    end

    def colour_next_vertex!
      # FIXME: consider colouring G graph’s vertex first
      # FIXME: consider other vertex selection algorithms
      qv_vertex = (@qv_graph.vertices - @qv_colours.keys).min_by { |v| [-@qv_forbidden[v].size, -@qv_graph.degree(v)] }
      colour_qv_vertex! qv_vertex if qv_vertex
      g_vertex = (@g_graph.vertices - @g_colours.keys).min_by { |v| [-@g_forbidden[v].size, -@g_graph.degree(v)] }
      colour_g_vertex! g_vertex if g_vertex
    end

    def colour_qv!(qv_vertex, colour)
      return if @qv_colours[qv_vertex] == colour
      raise PaintingError if @qv_colours[qv_vertex] and @qv_colours[qv_vertex] != colour
      raise PaintingError if @qv_forbidden[qv_vertex].include? colour
      @qv_colours[qv_vertex] = colour
      @qv_graph.adjacent(qv_vertex).each { |adjacent| forbid_qv! adjacent, colour }
      if @qv_colours.any? { |q, col| q != qv_vertex and col == colour }
        @g_graph.vertices.select { |g| g & qv_vertex == g }.each do |g_vertex|
          v_parent = @beta_v.ints.find { |v| v & g_vertex == g_vertex }
          @g_graph.adjacent(g_vertex).select { |g| v_parent & g == g and qv_vertex & g != g }.each do |neighbour|
            @qv_graph.vertices.select { |q| q & neighbour == neighbour }.each do |q_parent|
              forbid_qv! q_parent, colour
            end
          end
          siblings_of(g_vertex).each { |sibling| sync_colours g_vertex, sibling }
        end
      end
    end

    def colour_qv_vertex!(qv_vertex)
      backup!
      colour = :a
      colour = colour.next while @qv_forbidden[qv_vertex].include? colour
      colour_qv! qv_vertex, colour
    rescue PaintingError
      restore!
      forbid_qv! qv_vertex, colour
      retry
    end

    def forbid_g!(g_vertex, colour)
      return if @g_forbidden[g_vertex].include? colour
      raise PaintingError if colour == @g_colours[g_vertex]
      @g_forbidden[g_vertex] << colour
      siblings_of(g_vertex).each { |sibling| forbid_g! sibling, colour }
    end

    def forbid_qv!(qv_vertex, colour)
      return if @qv_forbidden[qv_vertex].include? colour
      raise PaintingError if colour == @qv_colours[qv_vertex]
      @qv_forbidden[qv_vertex] << colour
    end

    def painted?
      @qv_graph.vertices == @qv_colours.keys.to_set and @g_graph.vertices == @g_colours.keys.to_set
    end

    def restore!
      @g_colours    = Marshal.load @backup[:g_colours]
      @g_forbidden  = Marshal.load @backup[:g_forbidden]
      @qv_colours   = Marshal.load @backup[:qv_colours]
      @qv_forbidden = Marshal.load @backup[:qv_forbidden]
      @g_forbidden.default_proc  = proc { |h, k| h[k] = Set[] }
      @qv_forbidden.default_proc = proc { |h, k| h[k] = Set[] }
    end

    def siblings_of(g_vertex)
      v_parent = @beta_v.ints.find { |v| v & g_vertex == g_vertex }
      colours  = @qv_colours.select { |q, _col| g_vertex & q == g_vertex }.values
      similar  = @qv_colours.select { |_q, col| colours.include? col }.keys
      (similar.map { |q| q & v_parent }.to_set & @g_graph.vertices).delete g_vertex
    end

    def sync_colours(v1, v2)
      (@g_forbidden[v1] - @g_forbidden[v2]).each { |col| forbid_g! v2, col }
      (@g_forbidden[v2] - @g_forbidden[v1]).each { |col| forbid_g! v1, col }
      if    @g_colours[v1] then colour_g! v2, @g_colours[v1]
      elsif @g_colours[v2] then colour_g! v1, @g_colours[v2]
      end
    end
  end
end

require 'fileutils'
require 'trollop'

require_relative 'logging'

module ArtDecomp
  class Executable
    def initialize(args, opts = { logging_class: Logging })
      options = Trollop.options args do
        opt :archs, 'Target architecture(s)', required: true, type: :strings
        opt :dir,   'Results directory',      required: true, type: :string
        opt :log,   'Logging level',          type: :string
        opt :uv,    'UV generator(s)',        default: ['RelativeRelevance']
        opt :qu,    'Qu generator(s)',        default: ['EdgeLabels']
        opt :qv,    'Qv generator(s)',        default: ['GraphColouring']
      end

      Trollop.die 'no FSM given'       if     args.empty?
      Trollop.die 'FSM does not exist' unless File.exist? args.first

      Trollop.die :archs, 'not in the form of inputs/outputs' unless options[:archs].all? { |s| s =~ %r{^\d+/\d+$} }
      Trollop.die :uv,    'generator does not exist'          unless (options[:uv] - UVGenerators.constants.map(&:to_s)).empty?
      Trollop.die :qu,    'generator does not exist'          unless (options[:qu] - QuGenerators.constants.map(&:to_s)).empty?
      Trollop.die :qv,    'generator does not exist'          unless (options[:qv] - QvGenerators.constants.map(&:to_s)).empty?

      self.archs = options[:archs].map { |s| Arch[*s.split('/').map(&:to_i)] }.to_set
      self.name  = File.basename args.first
      self.dir   = "#{options[:dir]}/#{name}/#{archs.sort.map(&:to_s).join(' ').tr('/', ':')}"
      self.fsm   = FSM.from_kiss args.first
      self.uv    = options[:uv].map { |name| UVGenerators.const_get(name).new }
      self.qu    = options[:qu].map { |name| QuGenerators.const_get(name).new }
      self.qv    = options[:qv].map { |name| QvGenerators.const_get(name).new }

      opts.fetch(:logging_class).new options[:log] if options[:log_given]
    end

    attr_accessor :archs, :fsm, :name

    def run(opts = {})
      dir << '/' + opts.fetch(:dir_prefix, Time.now.to_s)
      FileUtils.mkdir_p dir

      dt_gen_class = opts.fetch :dec_tree_generator_class, DecTreeGenerator
      dt_gen = dt_gen_class.new archs: archs, fsm: fsm, gens: { uv: uv, qu: qu, qv: qv }
      dt_gen.dectrees.each.with_index do |dectree, i|
        File.write "#{dir}/#{name}_#{i}.vhdl", dectree.to_vhdl("#{name}_#{i}")
      end
    end

    protected

    attr_accessor :dir, :qu, :qv, :uv
  end
end

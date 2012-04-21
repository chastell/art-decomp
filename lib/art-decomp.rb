require 'ostruct'
require 'set'
require 'yaml'

module ArtDecomp
  DontCare = :-
end

Dir["#{File.dirname(__FILE__)}/**/*.rb"].sort.each { |f| require f }

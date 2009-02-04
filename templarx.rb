require 'erb'
require 'fileutils'

class Templarx  
  TEMPLATE_PATH = File.join(File.dirname(__FILE__), 'drum_definition.erb')

  attr_accessor :probabilities
  attr_accessor :default
  
  def initialize opts={}
    opts = {:default => 0.5,
            :definition_path => File.join(File.dirname(__FILE__), 'test.rb')}.merge opts
    @ddpath = opts[:definition_path]
    @default = opts[:default]
    @probabilities = opts[:probabilities]
  end

  # 10x16 array of 0.0-1.0
  # rows represent midi channels, columns sixteenth notes
  def initialize_probabilities
    @probabilities = {}
    (36..45).each{|i| @probabilities[i] = Array.new(16, @default)}
  end
  
  def template
    @template ||= open(TEMPLATE_PATH).read
  end
  
  def rewrite_drum_definition
    e = ERB.new template
    File.open(@ddpath, "w"){|f| f << e.result(binding)}
  end
end

class SimpleBuilder
  VERSION = "1.0.1"

  attr_accessor :params, :object

  def initialize params, object = nil, &block
    self.params = params
    if block_given?
      yield self
    end
    self.object = object || new_instance
  end

  # Builder Contract:
  def new_instance
  end

  def set_attributes
  end
  # end of Contract

  def self.build params, &block
    new(params, &block).build!
  end

  def self.update object, params
    new(params, object).update!
  end

  def build!
    set_attributes
    object.save
    object
  end
  alias_method :update!, :build!

end

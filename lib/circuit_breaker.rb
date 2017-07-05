class CircuitBreaker
  def initialize(&block)
    @circuit = block
  end

  def act
    @circuit.call
  end
end

class CircuitBreaker
  def initialize(&block)
    @circuit = block
  end

  def execute
    @circuit.call
  rescue Timeout::Error
    'Timeout Error'
  end
end

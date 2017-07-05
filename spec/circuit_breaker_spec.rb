require 'net/http'
require 'webmock/rspec'
require_relative '../lib/circuit_breaker'

describe 'Circuit breaker' do
  it 'executes an HTTP call when initialized with it' do
    host = 'www.example.com'
    response = 'some response'
    stub_request(:get, host).to_return(body: response)

    block = lambda { Net::HTTP.get(host, '/') }
    circuit_breaker = CircuitBreaker.new(&block)

    expect(circuit_breaker.act).to eq response
  end
end

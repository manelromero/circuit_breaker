require 'net/http'
require 'webmock/rspec'
require_relative '../lib/circuit_breaker'

describe 'Circuit breaker' do
  let(:host) { 'www.testing.com' }

  it 'executes a block call' do
    response = 'some response'
    stub_request(:get, host).to_return(body: response)

    expect(circuit_breaker.execute).to eq response
  end

  it 'raises an exception when timeout' do
    stub_request(:get, host).to_timeout

    expect(circuit_breaker.execute).to eq 'Timeout Error'
  end
end

def circuit_breaker
  block = lambda { Net::HTTP.get(host, '/') }
  CircuitBreaker.new(&block)
end

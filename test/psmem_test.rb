require "test_helper"

class PsmemTest < Minitest::Test
  test 'defines version number' do
    refute_nil ::Psmem::VERSION
  end

  test 'results for process' do
    psmem = Psmem.new('bash')

    refute_empty psmem.results

    result = psmem.results.first

    assert_equal 'bash', result.first
    assert_instance_of Hash, result.last
    assert_includes result.last, :count
    assert_includes result.last, :memory
  end

  test 'results for multiple processes' do
    psmem = Psmem.new('bash', 'ps')

    assert_equal 2, psmem.results.size
  end

  test 'results for unknown process' do
    psmem = Psmem.new('thisisnottheprocessyouarelookingfor')

    assert_equal([['thisisnottheprocessyouarelookingfor', {
      count: 0, memory: 0
    }]], psmem.results)
  end
end

require "psmem/version"

class Psmem
  def initialize(*processes)
    @processes = processes
  end

  def results
    @results ||= @processes.zip(collect_results)
  end

  def output_results!
    results.each.with_index do |(process, result), index|
      count  = result[:count]
      memory = result[:memory]

      puts "#{index.zero? ? '' : "\n"}#{process}"
      puts "Total Processes:  \t#{count}"
      puts "Total Memory:     \t#{memory.round(2)} MB"
      puts "Memory / Process: \t#{(memory / count).round(2)} MB"
    end
  end

  private

  def collect_results
    @processes.map do |process|
      { count: 0, memory: 0 }.tap do |result|
        self.class.exec_ps_for process do |line|
          result[:count]  += 1
          result[:memory] += line.match(/\A\d+\s+(\d+)/)[1].to_i / 1024.0
        end
      end
    end
  end

  def self.exec_ps_for(process, &block)
    %x[ps -C #{process} -O rss].split(/\s*\n\s*/).tap { |lines| lines.slice! 0 }.each(&block)
  end
end

class Reindeer < Struct.new(:name, :speed, :run_period, :rest_period)
  def run_time(time)
    full_period = run_period + rest_period

    full_periods_count = time / full_period
    full_periods_run_time = full_periods_count * run_period

    last_period_remaining_time = time % full_period
    last_period_run_time = [last_period_remaining_time, run_period].min

    full_periods_run_time + last_period_run_time
  end

  def run_distance(time)
    run_time(time) * speed
  end
end


def read_input(input_text)
  input_text.split("\n").map do |line|
    match = line.match(/(.*) can fly (.*) km\/s for (.*) seconds, but then must rest for (.*) seconds./)
    name = match[1]
    speed = match[2].to_i
    run_period = match[3].to_i
    rest_period = match[4].to_i
    Reindeer.new(name, speed, run_period, rest_period)
  end
end


if __FILE__ == $0
  input_file_name = ARGV[0]
  File.open(input_file_name, "r") do |file|
    reindeers = read_input(file.read)
    time = 2503
    printf("%d\n", reindeers.map { |reindeer| reindeer.run_distance(time) }.max)
  end
end
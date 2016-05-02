
total_volume = 150
if __FILE__ == $0

  volumes = []
  input_file_name = ARGV[0]
  File.open(input_file_name) do |file|
    file.each_line do |line|
      volumes.push(line.to_i)
    end
  end
  volume_match = 0
  has_matched = false
  (1..volumes.length).each do |container_count|
    
    volumes.combination(container_count).each do |containers|
      total_volume_of_containers = containers.reduce(:+)
      volume_match +=1 if total_volume_of_containers == total_volume
    end
    if !has_matched && volume_match > 0
      puts "Total of minimum container count matches: #{volume_match}"
      has_matched = true
    end 
  end
  puts "Total matching combos: #{volume_match}"
end

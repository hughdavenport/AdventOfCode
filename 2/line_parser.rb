class LineParser
  def initialize(file)
    @file = file
  end
  
  def each
    @file.each_line do |line|
      yield line.split('x').map(&:to_i)
    end
  end
end
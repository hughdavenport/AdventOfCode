class Turing
  def initialize(commands)
    @commands = commands
    @registers = { 'a' => 0, 'b' => 0 }
    @current_command_index = 0
  end

  def execute
    execute_current_command until !(0...@commands.size).include?(@current_command_index)
  end

  def execute_current_command
    current_command = @commands[@current_command_index]

    hlf_match = current_command.match(/hlf (.)/)
    if hlf_match
      register = hlf_match[1]
      @registers[register] /= 2
      @current_command_index += 1
      return
    end

    inc_match = current_command.match(/inc (.)/)
    if inc_match
      register = inc_match[1]
      @registers[register] += 1
      @current_command_index += 1
      return
    end

    jio_match = current_command.match(/jio (.), (.*)/)
    if jio_match
      register = jio_match[1]
      offset = jio_match[2].to_i
      if @registers[register] == 1
        @current_command_index += offset
      else
        @current_command_index += 1
      end
      return
    end

    tpl_match = current_command.match(/tpl (.)/)
    if tpl_match
      register = tpl_match[1]
      @registers[register] *= 3
      @current_command_index += 1
      return
    end

    jie_match = current_command.match(/jie (.), (.*)/)
    if jie_match
      register = jie_match[1]
      offset = jie_match[2].to_i
      if @registers[register].even?
        @current_command_index += offset
      else
        @current_command_index += 1
      end
      return
    end

    jmp_match = current_command.match(/jmp (.*)/)
    if jmp_match
      offset = jmp_match[1].to_i
      @current_command_index += offset
      return
    end
  end

  def register(register_name)
    @registers[register_name]
  end
end

if __FILE__ == $0
  input_file_name = ARGV[0]
  input = File.read(input_file_name)
  commands = input.split("\n")

  turing = Turing.new(commands)
  turing.execute

  puts "Register b: #{turing.register('b')}"
end
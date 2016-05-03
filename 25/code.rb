row = ARGV[0].to_i
col = ARGV[1].to_i
puts row, col

code = 20151125

r = 1
c = 1

begin
  #puts r, c, code
  r -= 1
  c += 1
  if r == 0
    r = c
    c = 1
  end
  code = (code * 252533) % 33554393
end while !(r == row && c == col)
puts code

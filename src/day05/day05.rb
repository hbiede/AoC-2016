require 'digest'

Result = Struct.new(:char, :position, :index)

def next_interesting_hash(base, start_index=0)
  while true
    hashed = Digest::MD5.hexdigest("#{base}#{start_index}")
    
    if hashed.start_with? "00000"
      res = Result.new
      res.position = hashed.chars[5]
      res.char = hashed.chars[6]
      res.index = start_index
      return res
    end
    
    start_index += 1
  end
end

def generate_password(input, in_order=true)
  new_password = "________"
  start_index = 0
  while new_password.include? "_"
    res = next_interesting_hash(input, start_index)
    if in_order
      res.char = res.position
      res.position = new_password.index "_"
    else
      res.position = res.position.to_i(16)
    end
    
    if res.position >=0 and res.position < new_password.length && new_password.chars[res.position] == "_"
      new_password = new_password.chars.map.with_index { |c,i| i == res.position ? res.char : c }.join
    else
      puts "Skipping: #{res.position}, #{res.char}"
    end
    
    start_index = res.index + 1
  end
  new_password
end

input = "ffykfhsq"


puts generate_password(input, false)

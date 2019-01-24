module Base62_Helper
  
  KEYS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze

  def encode(id)
    str = ''
    while id > 0
      str.prepend KEYS[id % KEYS.size]
      id = id / KEYS.size
    end
    return str
  end

  def self.decode(str)
    id = 0
    str.chars.reverse.each_with_index do |char, index|
      position = KEYS.size ** index
      id = id + KEYS.index(char) * position
    end
    return id
  end
end
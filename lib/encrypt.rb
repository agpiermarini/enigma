require "Date"
require "Time"
require "pry"

class Encrypt

  def random_key(length, ceiling)
    length.times.map { Random.rand(ceiling) }
  end

  def random_key_offset(key)
    key.map.with_index do | element , index |
    "#{element}#{key[index+1]}".to_i
    end.shift(4)
  end

  def create_date
    Date.today
  end


end

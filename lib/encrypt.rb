require "Date"
require "Time"
require "pry"

class Encrypt

  def random_key(length, ceiling)
    length.times.map { Random.rand(ceiling) }
  end

  def key_offset(key = random_key(5, 10))             #problematic for edge cases? can we hard code in random_key and still have appropriate tests
    key.map.with_index do | element , index |
    "#{element}#{key[index+1]}".to_i
    end.shift(4)
  end

  def date_string
      Date.today.strftime("%m%d%y")
  end

  def date_offset
      date_string.split("",2)
  end

end

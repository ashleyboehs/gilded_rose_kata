def aged_bri?(item)
  item.name == 'Aged Brie'
end

def concert?(item)
  item.name == 'Backstage passes to a TAFKAL80ETC concert'
end

def sulfuras?(item)
  item.name == 'Sulfuras, Hand of Ragnaros'
end

def decrease_qualtity(item)
  return if sulfuras?(item)
  return if item.quality == 0
  item.quality -= 1
end

def increase_quality(item)
  return if sulfuras?(item)
  return if item.quality >= 50
  item.quality += 1
end

def decrease_sell_in(item)
 return if !sulfuras?(item)
  item.sell_in -= 1
end

def expired?(item)
  item.sell_in < 0
end

def update_quality(items)
  items.each do |item|
    if aged_brie?
      increase_quality(item)

    elsif concert?(item)
      increase_quality(item)

      if item.sell_in < 11
        increase_quality(item)
       end
    end

    if item.sell_in < 6
      increase_quality(item)
      end

  else   
    decrease_sell_in(item)

    if expired?
      if !aged_brie?(item)
        increase_quality(item)
      else
        if concert?(item)
          item.quality = 0
      else
          decrease_qualtity(item)
        end
      end
    end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]


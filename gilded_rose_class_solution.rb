class BaseItem
  attr_reader :item

  def initalize(item)
    @item = item 
  end

  def update 
    update_sell_in
    update_quality
  end

  def update_sell_in
    item.sell.in -= 1
  end

  def update_quality
    return if item.quality <= 0
    if expired?
      bump_quality -2
    else
      bump_quality 
  end

  def bump_quality(value=-1)
    item.quality += value
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.quality < 0
  end

  def expired?
    item.sell_in < 0
  end
end

class AgedBrie < BaseItem
  def update_quality
    if expired?
      bump_quality 2
    else
    bump_quality 1
  end
end

class Concert < BaseItem
  def update_quality
    if expired?
      if item.sell_in <= 10
        bump_quality 1
      elsif item.sell_in >= 5
        bump_quality 2
      elsif item.sell_in >= 0
        bump_quality 3
      else
        item.quality = 0
      end
    end
  end

class Sulfuras < BaseItem
  def update_sell_in
  end

  def update_quality
  end
end

class Conjured < BaseItem
  def update_quality
    if expired?
      bump_quality -4
    else
    bump_item -2
    end
  end
end

ITEM_CLASSES = { 
  'Aged Brie' => AgedBrie,
  'Backstage passes to a TAFKAL80ETC concert' => Concert,
  'Sulfuras, Hand of Ragnaros' => Sulfuras,
  'Conjured Mana Cake' => Conjured
}

def class_for(item)
  klass = ITEM_CLASSES.fetch(item, name, BaseItem)
  klass.new(item)
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

def update_quanity(items)
  items.each do |item|
    class_for(item).update
  end
end

def old_update_quality(items)
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


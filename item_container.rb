module ItemContainer
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def increment_total_items
      @total_items ||= 0
      @total_items += 1
    end
  end

  module InstanceMethods
    def add_item(item)
      items << item
      self.class.increment_total_items
    end

    def remove_item(item)
      items.delete(item)
    end

    def delete_items
      items.clear
    end

    def show_all_items
      items.each { |item| puts item }
    end

    def total_items
      self.class.total_items
    end
  end
end

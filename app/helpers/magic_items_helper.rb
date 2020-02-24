module MagicItemsHelper
  def render_base_description(item)
    result = []

    result << item.item_type
    result << "wondrous item" if item.wondrous
    result << item.rarity.downcase
    puts result.inspect
    result = result.delete_if { |str| str.empty? }
    result = result.join(', ')

    if !item.attunement.nil? && !item.attunement.empty?
      if item.attunement == "true"
        result << " (requires attunement)"
      else
        result << " (requires attunement #{item.attunement})"
      end
    end
    result.capitalize
  end
end

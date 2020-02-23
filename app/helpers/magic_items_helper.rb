module MagicItemsHelper
  def render_base_description(item)
    result = ""
    if item.wondrous
      result << "Wondrous item, "
    end
    result << item.rarity.downcase
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

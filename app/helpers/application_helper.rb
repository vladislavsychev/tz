module ApplicationHelper

# Returns the full title on a per-page
  def full_title(page_title)
    base_title = "TaxiZi. Use pre order and get best offer. Limo, vip-class sedan and van"
	if page_title.empty?
	  base_title
	else
	  "#{base_title} | #{page_title}"
	end
  end

end

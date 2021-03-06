# -*- encoding : utf-8 -*-
module ApplicationHelper

# Returns the full title on a per-page
  def full_title(page_title)
    base_title = "Такси Zi. Выбор с экономией."
	if page_title.empty?
	  base_title
	else
	  "#{base_title} | #{page_title}"
	end
  end

  def wrap(content)
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  # enable i18n in will_paginate
  include WillPaginate::ViewHelpers

  def will_paginate_with_i18n(collection = nil, options = {})
    will_paginate collection, options.merge(:previous_label => I18n.t(:previous), :next_label => I18n.t(:next))
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end


end

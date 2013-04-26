# == Schema Information
#
# Table name: contracts
#
#  id                :integer          not null, primary key
#  t_car             :integer
#  city_rent         :string(99)
#  date_rent         :date
#  time_rent         :string(5)
#  lease_time        :integer
#  body_contract     :text
#  contractor_mphone :string(12)
#  contractor_email  :string(140)
#  contractor_name   :string(50)
#  active            :boolean          default(FALSE)
#  close_contract    :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Contract do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: attached_assets
#
#  id                 :integer          not null, primary key
#  asset_file_name    :string(255)
#  asset_content_type :string(255)
#  asset_file_size    :integer
#  asset_updated_at   :datetime
#  attachable_id      :integer
#  attachable_type    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe AttachedAsset do
  pending "add some examples to (or delete) #{__FILE__}"
end

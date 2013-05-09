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

class AttachedAsset < ActiveRecord::Base

  attr_accessible :asset, :asset_file_name

  belongs_to :attachable, :polymorphic => true
  has_attached_file :asset, :styles => { :mini => "240x120#", :middle => "360x180#", :normal => "600x300#" }

  validates_attachment   :asset, :content_type => { :content_type => /^image\/(png|jpg|jpeg)/}, :size => { :in => 0..200.kilobytes }
end

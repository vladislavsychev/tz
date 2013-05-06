class AttachedAsset < ActiveRecord::Base

  attr_accessible :asset, :asset_file_name

  belongs_to :attachable, :polymorphic => true
  has_attached_file :asset, :styles => { :mini => "240x120#", :middle => "360x180#", :normal => "600x300#" }

  validates_attachment   :asset, :content_type => { :content_type => /^image\/(png|jpg|jpeg)/}, :size => { :in => 0..150.kilobytes }
end

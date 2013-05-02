class AttachedAsset < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :attachable, :polymorphic => true
  has_attached_file :asset, :styles => { :mini => "240x120#", :middle => "360x180#", :normal => "800x400#" }

  attr_accessible :asset, :asset_file_name

end

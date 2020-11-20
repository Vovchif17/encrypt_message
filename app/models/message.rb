# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  password_digest :string
#  text            :string
#  uuid            :string
#  viewed          :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'aes'

class Message < ApplicationRecord
  has_secure_password

  scope :not_viewer, -> {where(viewed: false )}

  validates :text, presence: true
  validates :password, presence: true

  before_create :set_uuid
  before_create :encrypt!

  def decrypted_message
    AES.decrypt(text, Rails.application.credentials.message_key)
  end

  private

  def encrypt!
    self.text = AES.encrypt(text, Rails.application.credentials.message_key)
  end

  def set_uuid
    self.uuid = SecureRandom.hex(15)
  end
end
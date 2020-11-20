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
class MessageSerialize < ActiveModel::Serialize
  attribute :text do
    if object_viewed?
      'you already request this message'
    elsif object.autenteficate(instance_option[:password])
      object.update!(viewed: true, password:instance_option[:password])
      object.decrypted_message
    else
      object.text
    end
  end
end

# frozen_string_literal: true

class WechatUtils
  def self.encrypt(data, iv, session_key)
    cipher = OpenSSL::Cipher.new('AES-128-CBC')
    cipher.encrypt
    cipher.key = Base64.decode64(session_key)
    cipher.iv = Base64.decode64(iv)
    Base64.encode64(cipher.update(data.to_json) + cipher.final)
  end

  def self.decrypt(encrypted_data, iv, session_key)
    cipher = OpenSSL::Cipher.new('AES-128-CBC')
    cipher.decrypt
    cipher.key = Base64.decode64(session_key)
    cipher.iv = Base64.decode64(iv)
    JSON.parse(cipher.update(Base64.decode64(encrypted_data)) + cipher.final)
  end
end

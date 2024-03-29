class User < ApplicationRecord
  attr_accessor :remember_token
  VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates :name, presence: true,length: { maximum: 50 }
  validates :email, presence: true,length: { maximum: 255 },uniqueness: true
  validates :password, presence: true, length: { minimum: 6 },allow_nil: true
  has_secure_password
   # 返回指定字符串的哈希摘要
   # 返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # 返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  # 为了持久会话，在数据库中记住用户
  def remember
    self.remember_token = User.new_token update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 如果指定的令牌和摘要匹配，返回 true
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  # 忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end
end

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :confirmable
         # :encryptable

  has_many :roles, :through => :users_roles
  has_many :topics
  has_many :pictures
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner

  ALLOW_LOGIN_CHARS_REGEXP = /\A\w+\z/
  validates :name, format: { with: ALLOW_LOGIN_CHARS_REGEXP, message: '只允许数字、大小写字母和下划线' },
                    length: { in: 3..20 }, presence: true,
                    uniqueness: { case_sensitive: true}

  # 发送欢迎邮件
  after_create :send_welcome_mail
  def send_welcome_mail
    UserMailer.welcome(id).deliver_later
  end

  # 分配默认角色
  after_create :assign_default_role
  def assign_default_role
    self.add_role(:member) if self.roles.blank?
  end

  # 登录时可使用 用户名和邮箱
  def login=(login)
    @login = login
  end

  def login
    @login || self.name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

end

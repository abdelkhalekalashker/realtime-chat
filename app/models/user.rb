class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to 'users' }

  has_many :messages, dependent: :destroy
  has_many :joinables, dependent: :destroy
  has_many :joined_rooms, through: :joinables, source: :room

  enum role: %i[user admin]

  after_initialize :set_default_role, if: :new_record?

  def has_joined(room)
    joined_rooms.include?(room)
  end

  def joinable_rooms
    Room.public_rooms.joins(:joinables).where.not(joinables: {user_id: id})
  end

  private

  def set_default_role
    self.role ||= :user
  end
end

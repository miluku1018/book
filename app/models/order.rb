class Order < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :order_items

  validates :recipient, :tel, :address, presence: true
  validates :num, uniqueness: true

  before_create :generate_num #不能寫在before_save因為每次更新都會產生一次...但是訂單編號是唯一的
 
  def total_price
    order_items.reduce(0) {|sum, item| sum + item.sell_price}.to_i
  end
  
  aasm column: 'state', no_direct_assignment: true do
    state :pending, initial: true
    state :paid, :delivered, :cancelled

    event :pay do
      before do |args|
        self.transaction_id = args[:transaction_id]
      end
      # args是一個hash,所以取值要用[:transition_id]
      transitions from: :pending, to: :paid
    end

    event :deliver do
      transitions from: :paid, to: :delivered
      after do
        puts '------'
        puts 'hello #{user.email}'
        puts '------'
      end
    end

    event :cancel do
      transitions from: [:pending, :paid, :delivered], to: :cancelled
    end

  end
 
  private
  def generate_num
    self.num = SecureRandom.hex(6).upcase #self呼叫作用
  end
end

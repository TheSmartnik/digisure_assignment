class Transaction < ApplicationRecord
  belongs_to :user

  OPERATION_TYPES = [
    DEPOSIT = :deposit,
    TRANSFER_SENT = :transfer_sent,
    TRANSFER_RECEIVED = :transfer_received,
  ].freeze

  INCOMING_OPERATIONS = [
    DEPOSIT,
    TRANSFER_RECEIVED
  ].freeze

  OUTGOING_OPERATIONS = [
    TRANSFER_SENT
  ].freeze

  enum operation_type: {
    DEPOSIT => 0,
    TRANSFER_SENT => 1,
    TRANSFER_RECEIVED => 2,
  }

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  scope :incoming, -> { where(operation_type: INCOMING_OPERATIONS) }
  scope :outgoing, -> { where(operation_type: OUTGOING_OPERATIONS) }

  scope :incoming_sum, -> { incoming.sum(:quantity) }
  scope :outgoing_sum, -> { outgoing.sum(:quantity) }

  class << self
    def balance
      incoming_sum - outgoing_sum
    end
  end
end

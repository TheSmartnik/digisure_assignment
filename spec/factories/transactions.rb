FactoryBot.define do
  factory :transaction do
    user
    operation_type { 0 }
    quantity { 100 }
  end
end

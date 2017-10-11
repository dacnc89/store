class Card < ApplicationRecord

  belongs_to :order
  has_one :card_transaction

  attr_accessor :card_number, :card_verification

  before_create :validate_card


  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    #response = GATEWAY.purchase(price_in_cents, credit_card)
    create_card_transaction(action: "purchase", amount: price_in_cents, response: response)
    order.update_attrubute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def price_in_cents
    (order.fee_amount*100).round
  end

  private
  
  def purchase_options
    {
      ip: ip_address,
      billing_address: {
        name:     "current_user.name",
        address1: "current_user.ship_address.ward",
        city:     "current_user.ship_address.city",
        state:    "current_user.ship_address.district",
        country:  "vietnam",
        zip:      "084"
      }
    }
  end

  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |msg|
        errors.add :base, msg
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      type:              card_type,
      number:            card_number,
      verification_value:card_verification,
      month:             card_expires_on.month,
      year:              card_expires_on.year,
      first_name:        first_name,
      last_name:         last_name
    )
  end

end


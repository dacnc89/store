require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "invalid without a name" do
    p = Product.new
    assert !p.valid?, "Name cant be blank"
  end
end

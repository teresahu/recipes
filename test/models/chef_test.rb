require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.new(chefname: "Gordon Ramsey", email: "ramsey@hellskitchen.com")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chefname should not be too short" do
    @chef.chefname = "aaaa"
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should not be too long" do
    @chef.email = "a" * 101 + "@hellskitchen.com"
    assert_not @chef.valid?
  end

  test "email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w(user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm)
    valid_addresses.each do |a|
      @chef.email = a
      assert @chef.valid?, '#{a.inspect} should be valid.'
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w(user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com)
    invalid_addresses.each do |a|
      @chef.email = a
      assert_not @chef.valid?, "#{a.inspect} should be invalid."
    end
  end
end

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  before do
    @account = Bank::SavingsAccount.new(12345, 100.0)
  end
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      @account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # TODO: Your test code here!
      @account.balance.must_be  :>=, 10.0

      proc {
        Bank::SavingsAccount.new(12345, 5.0)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # TODO: Your test code here!
      @account.withdraw(10.0)
      @account.balance.must_equal 88.0
    end

    it "Outputs a warning if the balance would go below $10" do
      # TODO: Your test code here!
      proc {
        @account.withdraw(95.0)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if it would go below $10" do
      # TODO: Your test code here!
      start_balance = 100.0
      updated_balance = @account.withdraw(200.0)

      updated_balance.must_equal start_balance
      @account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # TODO: Your test code here!
      start_balance = 100.0
      updated_balance = @account.withdraw(89.0)

      updated_balance.must_equal start_balance
      @account.balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      # TODO: Your test code here
      @account.add_interest(0.25).must_equal 0.25
    end

    it "Updates the balance with calculated interest" do
      # TODO: Your test code here!
      balance = 100.25
      @account.add_interest(0.25)
      @account.balance.must_equal balance
    end

    it "Requires a positive rate" do
      # TODO: Your test code here!
      proc {
        @account.add_interest(-10)
      }.must_raise ArgumentError
    end
  end
end

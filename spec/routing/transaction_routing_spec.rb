require "spec_helper"

describe TransactionsController do
  describe "routing" do
    it "routes to #create" do
      post("/checkouts").should route_to("checkouts#create")
    end
  end
end

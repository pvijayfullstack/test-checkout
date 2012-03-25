require 'spec_helper'


describe CheckoutsController do

  def valid_attributes
    FactoryGirl.attributes_for(:checkout)
  end


  describe "GET index" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "assigns all checkouts as @checkouts" do
      @test_checkout = FactoryGirl.build(:checkout)
      Checkout.should_receive(:all).and_return([@test_checkout])
      get :index
      assigns(:checkouts).should eq([@test_checkout])
    end
  end

  describe "GET new" do
    it "assigns a new checkout as @checkout" do
      get :new, {:pricing_rules => []}
      assigns(:checkout).should be_a_new(Checkout)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Checkout" do
        expect {
          post :create, {:checkout => valid_attributes}
        }.to change(Checkout, :count).by(1)
      end

      it "assigns a newly created checkout as @checkout" do
        post :create, {:checkout => valid_attributes}
        assigns(:checkout).should be_a(Checkout)
        assigns(:checkout).should be_persisted
      end

      it "redirects to the created checkout" do
        post :create, {:checkout => valid_attributes}
        response.should redirect_to(scan_checkout_path(Checkout.last))
      end
    end
    describe "with invalid params" do
      it "assigns a newly created but unsaved checkout as @checkout" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checkout.any_instance.stub(:save).and_return(false)
        post :create, {:checkout => {}}
        assigns(:checkout).should be_a_new(Checkout)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Checkout.any_instance.stub(:save).and_return(false)
        post :create, {:checkout => {}}
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested checkout" do
      checkout = Checkout.create! valid_attributes
      expect {
        delete :destroy, {:id => checkout.to_param}
      }.to change(Checkout, :count).by(-1)
    end

    it "redirects to the checkouts list" do
      checkout = Checkout.create! valid_attributes
      delete :destroy, {:id => checkout.to_param}
      response.should redirect_to(checkouts_url)
    end
  end

  describe "GET total" do
    it "assigns the requested checkout as @checkout" do
      @test_checkout = FactoryGirl.build(:checkout)
      Checkout.should_receive(:find).and_return(@test_checkout)
      get :total, {:id => 1}
      assigns(:checkout).should eq(@test_checkout)
    end
  end

  describe "GET scan" do
    it "assigns the requested checkout as @checkout" do
      @test_checkout = FactoryGirl.build(:checkout)
      Checkout.should_receive(:find).and_return(@test_checkout)
      get :scan, {:id => 1}
      assigns(:checkout).should eq(@test_checkout)
    end
  end
end

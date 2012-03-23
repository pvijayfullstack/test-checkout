class TransactionsController < ApplicationController
  def create
    @transaction = Transaction.new(params[:transaction])
    if @transaction.save
      redirect_to :back, :notice => 'Transaction added.'
    else
      redirect_to :back, :notice => 'Opps, something went wrong. Try again.'
    end
  end
end
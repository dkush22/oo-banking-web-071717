class Transfer

attr_accessor :sender, :receiver, :amount, :status
def initialize(sender, receiver, amount)

@@all = []

@sender = sender
@receiver = receiver
@status = "pending"
@amount = amount

end


def valid?
	if @sender.valid? && @receiver.valid? && self.status == "pending"
		true
	else false
	end
end

def execute_transaction
   if self.valid? && !@@all.include?(self)
      if @sender.balance >= @amount
        @sender.balance-=@amount
       @receiver.deposit(@amount)
        self.status='complete'
        @@all<<self
      else
        self.status='rejected'
        'Transaction rejected. Please check your account balance.'
      end
   else
      self.status='rejected'
    end
  end


def reverse_transfer
  if self.status=='complete' && @receiver.valid? && @sender.valid?
      if @receiver.balance>self.amount
        @receiver.balance-=self.amount
       @sender.deposit(self.amount)
        self.status='reversed'
      else
        'Cannot complete transaction'
      end
    end

end


end

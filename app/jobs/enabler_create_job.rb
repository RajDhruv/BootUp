class EnablerCreateJob < ApplicationJob
  queue_as :urgent

  def perform(enabler)
  	recipients=enabler.timeline.subscribers
  	recipients.each do |u|
		Notification.create(actor:enabler.author,recipient_id:u,notifiable:enabler.timeline.timeable,action:"Posted a #{enabler.enable.class.to_s}")
	end
  end
end

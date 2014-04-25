class MailchimpWorker
  include Sidekiq::Worker 

  def perform(visitor_id) 
    visitor = Visitor.find(visitor_id)
    visitor.subscribe
  end
end
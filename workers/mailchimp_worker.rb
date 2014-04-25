class MailchimpWorker
  include Sidekiq::Worker 

  def perform(visitor.id) 
    visitor = Visitor.find(visitor.id)
    visitor.subscribe
  end
end
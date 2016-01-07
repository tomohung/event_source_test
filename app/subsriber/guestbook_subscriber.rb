class GuestbookSubscriber
  def handle_event(event)
    byebug
    if event.event_type == 'ProductAdded'
      create_new_product(event.data)
    else
      byebug  
    end
  end

  private
    def create_new_product(event_data)
      byebug
      Guestbook.create(event_data.to_param)
    end
end


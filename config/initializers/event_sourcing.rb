guestbook = GuestbookSubscriber.new
client = RailsEventStore::Client.new
client.subscribe(guestbook, ['ProductAdded'])

json.array!(@guestbooks) do |guestbook|
  json.extract! guestbook, :id, :name, :content
  json.url guestbook_url(guestbook, format: :json)
end

class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_name)
    # Do something later
    sleep 60

    puts book_name
  end
end

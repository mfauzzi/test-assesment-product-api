class ProductsChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific channel
    stream_from "products_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

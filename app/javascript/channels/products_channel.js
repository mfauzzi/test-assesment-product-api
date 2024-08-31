import consumer from "./consumer"
import "../channels/products_channel"

consumer.subscriptions.create("ProductsChannel", {
  received(data) {
    console.log("Received data:", data);
    // Handle the received data (e.g., update UI)
  }
});

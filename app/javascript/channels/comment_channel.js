// app/javascript/channels/comment_channel.js
import consumer from "./consumer";

const postElement = document.getElementById("post-id"); // Ensure this element is in the view

if (postElement) {
  const postId = postElement.dataset.postId; // This is where the post ID is passed

  consumer.subscriptions.create(
    { channel: "CommentsChannel", post_id: postId },
    {
      received(data) {
        // Handle the incoming comment data (e.g., update the comments section)
        console.log(data); // Check the incoming data in the browser console
      },
      sendComment(content) {
        this.perform("send_comment", { content: content });
      },
    }
  );
}

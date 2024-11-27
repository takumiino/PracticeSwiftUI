import Foundation

struct Message: Identifiable, Hashable {
  let id = UUID().uuidString
  let message: String
  let isReply: Bool
}

let messages: [Message] = [
  Message(message: "Hello", isReply: false),
  Message(message: "Hi!", isReply: true),
  Message(message: "How are you?", isReply: false),
  Message(message: "I'm fine", isReply: true),
  Message(message: "What's up?", isReply: false),
  Message(message: "Nothing much", isReply: true),
  Message(message: "How about you?", isReply: false),
  Message(message: "I'm good", isReply: true),
  Message(message: "That's great", isReply: false),
  Message(message: "Yeah", isReply: true),
  Message(message: "Bye", isReply: false),
  Message(message: "Goodbye", isReply: true),
  Message(message: "See you later", isReply: false),
  Message(message: "See you soon", isReply: true),
  Message(message: "Take care", isReply: false),
  Message(message: "You too", isReply: true),
  Message(message: "Have a nice day", isReply: false),
  Message(message: "Hello", isReply: false),
]

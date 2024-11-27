import Foundation
struct Profile: Identifiable, Hashable {
  let id = UUID().uuidString
  let userName: String
  let profilePicture: String
  let lastMsg: String
}

let profiles: [Profile] = [
  Profile(userName: "たくみ", profilePicture: "oyster", lastMsg: "What's up?"),
  Profile(userName: "だいき", profilePicture: "oyster", lastMsg: "Hey!"),
  Profile(userName: "ひかる", profilePicture: "oyster", lastMsg: "Hello!"),
  Profile(userName: "せいご", profilePicture: "oyster", lastMsg: "Hi!"),
]

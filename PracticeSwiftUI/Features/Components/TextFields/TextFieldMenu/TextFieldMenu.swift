import SwiftUI

struct TextFieldMenu: View {
  @State private var message: String = ""
  @State private var selection: TextSelection?

  var body: some View {
    NavigationStack {
      List {
        Section("TextField") {
          TextField("Message", text: $message, selection: $selection)
            .menu(showSuggesstions: true) {
              TextFieldAction(title: "大文字") { _, textField in
                if let selectionRange = textField.selectedTextRange,
                   let selectedText = textField.text(in: selectionRange) {
                  let upperCasedText = selectedText.uppercased()
                  textField.replace(selectionRange, withText: upperCasedText)

                  textField.selectedTextRange = selectionRange
                }
              }

              TextFieldAction(title: "小文字") { _, textField in
                if let selectionRange = textField.selectedTextRange,
                   let selectedText = textField.text(in: selectionRange) {
                  let lowerCasedText = selectedText.lowercased()
                  textField.replace(selectionRange, withText: lowerCasedText)

                  textField.selectedTextRange = selectionRange
                }
              }

              TextFieldAction(title: "置き換え") { _, textField in
                if let selectionRange = textField.selectedTextRange {
                  let replacementText = "ヤッホー"

                  textField.replace(selectionRange, withText: replacementText)

                  if let start = textField.position(from: selectionRange.start, offset: 0),
                     let end = textField.position(from: selectionRange.start, offset: replacementText.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: end)
                  }
                }
              }
            }
        }

        Section {
          if let selection, !selection.isInsertion {
            Text("Some Text is Selected")
          }
        }
      }
      .navigationTitle("Custom TextField Menu")
    }
  }
}

#Preview {
  TextFieldMenu()
}

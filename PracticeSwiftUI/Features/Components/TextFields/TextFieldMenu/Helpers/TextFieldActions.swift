import SwiftUI

extension TextField {
  @ViewBuilder
  func menu(showSuggesstions: Bool = true, @TextFieldActionBuilder actions: @escaping () -> [TextFieldAction])  -> some View {
    self
      .background(TextFieldActionHelper(showSuggesstions: showSuggesstions, actions: actions()))
      .compositingGroup()
  }
}

struct TextFieldAction {
  var title: String
  var action: (NSRange, UITextField) -> ()
}

//@resultBuilderとは、複数要素の組み合わせ作業を、命令的ではなく宣言的に行得るようにする機能
//参考資料: https://speakerdeck.com/chocoyama/20fen-dewakaru-su-xi-resultbuilder-iosdc-2022
@resultBuilder
struct TextFieldActionBuilder {
  static func buildBlock(_ components: TextFieldAction...) -> [TextFieldAction] {
    components.compactMap({ $0 })
  }
}

fileprivate struct TextFieldActionHelper: UIViewRepresentable {
  var showSuggesstions: Bool
  var actions: [TextFieldAction]

  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }

  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    DispatchQueue.main.async {
      if let textField = view.superview?.superview?.subviews.last?.subviews.first as? UITextField {
        context.coordinator.originalDelegate = textField.delegate
        textField.delegate = context.coordinator
      }
    }
    return view
  }

  func updateUIView(_ uiView: UIView, context: Context) {

  }

  class Coordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldActionHelper
    init(parent: TextFieldActionHelper) {
      self.parent = parent
    }

    var originalDelegate: UITextFieldDelegate?

    func textFieldDidChangeSelection(_ textField: UITextField) {
      originalDelegate?.textFieldDidChangeSelection?(textField)
    }

    func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
      var actions: [UIMenuElement] = []
      let customActions = parent.actions.compactMap { item in
        let action = UIAction(title: item.title) { _ in
          item.action(range, textField)
        }

        return action
      }

      if parent.showSuggesstions {
        actions = customActions + suggestedActions
      } else {
        actions = customActions
      }

      let menu = UIMenu(children: actions)
      return menu
    }
  }
}

#Preview {
  TextFieldMenu()
}

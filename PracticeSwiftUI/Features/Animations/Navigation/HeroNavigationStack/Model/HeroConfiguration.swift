import SwiftUI

struct HeroConfiguration {
  var layer: String?
  var coordinates: (CGRect, CGRect) = (.zero, .zero)
  var isExpandedCompletely: Bool = false
  var activeID: String = ""
}

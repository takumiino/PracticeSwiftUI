import SwiftUI

struct ImageEffect: View {
  @State private var value = 0.5

  var body: some View {
    Image("oyster")
      .resizable()
      .scaledToFit()
      .frame(width: 300, height: 500)
      .blur(radius: value * 10)
      .overlay(alignment: .bottom) {
        LabeledContent("Blur") {
          Text(value, format: .percent.precision(.fractionLength(1)))
        }.font(.headline)
      }

    Slider(value: $value) {}
    minimumValueLabel: {
      Text("0%")
    } maximumValueLabel: {
      Text("100%")
    }
    .padding(.horizontal)
  }
}

#Preview {
  ImageEffect()
}

import SwiftUI

struct GaugeAnimation: View {
  @State private var value = 0.5

  var body: some View {
    VStack(spacing: 100) {
      Gauge(value: value) {
        Image(systemName: "fuelpump.fill")
          .foregroundStyle(value < 0.3 ? .orange : .green)
          .font(.headline)
          .symbolEffect(.bounce, value: value < 0.3 ? value : 0.0)
      } currentValueLabel: {
        Text(value, format: .percent.precision(.fractionLength(1)))
          .contentTransition(.numericText())
          .transaction {
            $0.animation = .default
          }
      }
      .gaugeStyle(.accessoryCircular)
      .tint(value < 0.3 ? .orange : .green)
      .scaleEffect(4.0)

      Slider(value: $value) {} minimumValueLabel: {
        Text("0")
      } maximumValueLabel: {
        Text("100")
      }
      .padding(.horizontal)
    }
  }
}

#Preview {
  GaugeAnimation()
}

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("Home", destination: Home())
        NavigationLink("Image Effect", destination: ImageEffect())
        NavigationLink("TextField Menu", destination: TextFieldMenu())
        NavigationLink("ColorfulScrollAnimation", destination: ColorfulScrollAnimation())
        NavigationLink("GaugeAnimation", destination: GaugeAnimation())
      }
    }
  }
}


#Preview {
    ContentView()
}

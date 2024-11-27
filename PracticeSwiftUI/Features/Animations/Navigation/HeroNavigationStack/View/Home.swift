import SwiftUI

struct Home: View {
  /// Hero Configuration
  @State private var config: HeroConfiguration = .init()
  @State private var selectedProfile: Profile?
  var body: some View {
    NavigationStack {
      List {
        ForEach(profiles) { profile in
          ProfileCardView(profile: profile, config: $config) { rect in
            config.coordinates.0 = rect
            config.coordinates.1 = rect
            config.layer = profile.profilePicture
            config.activeID = profile.id
            /// This is used for navigationDestination
            selectedProfile = profile

          }
        }
      }
      .navigationTitle("Messages")
      .manageHomeForOlderiOSVersion()
      .navigationDestination(item: $selectedProfile) { profile in
        DetailView(selectedProfile: $selectedProfile, profile: profile, config: $config)
      }
    }
    .overlay(alignment: .topLeading) {
      ZStack {
        if let image = config.layer {
          let destination = config.coordinates.1

          Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: destination.width, height: destination.height)
            .clipShape(.circle)
            .offset(x: destination.minX, y: destination.minY)
            .transition(.identity)
            .onDisappear {
              config = .init()
            }
        }
      }
      .animation(.snappy(duration: 0.3, extraBounce: 0), value: config.coordinates.1)
      .ignoresSafeArea()
      .opacity(config.isExpandedCompletely ? 0 : 1)
      .onChange(of: selectedProfile == nil) { oldValue, newValue in
        if newValue {
          config.isExpandedCompletely = false

          withAnimation(.easeInOut(duration: 0.3), completionCriteria:.logicallyComplete) {
            config.layer = nil
          } completion: {
            config.layer = nil
          }

        }
      }
    }
  }
}

#Preview {
  Home()
}

struct MessageCardView: View {
  var message: Message
  var body: some View {
    Text(message.message)
      .padding(10)
      .foregroundStyle(message.isReply ? Color.primary : .white)
      .background {
        if message.isReply {
          RoundedRectangle(cornerRadius: 15)
            .fill(.gray.opacity(0.3))
        } else {
          RoundedRectangle(cornerRadius: 15)
            .fill(.blue.gradient)
        }
      }
      .frame(maxWidth: 250, alignment: message.isReply ? .leading : .trailing)
      .frame(maxWidth: .infinity, alignment: message.isReply ? .leading : .trailing)
  }
}

extension View {
  @ViewBuilder
  func hideNavbarBackground() -> some View {
    if #available(iOS 18, *) {
      self
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
    } else {
      self
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden()
    }
  }

  @ViewBuilder
  func manageHomeForOlderiOSVersion() -> some View{
    if #available(iOS 18, *) {
      self
    } else {
      self
        .toolbar(.hidden, for: .navigationBar)
    }
  }
}

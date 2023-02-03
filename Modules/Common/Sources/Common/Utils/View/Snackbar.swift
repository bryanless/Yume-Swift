//
//  Snackbar.swift
//  
//
//  Created by Bryan on 03/02/23.
//

import Core
import SwiftUI

public struct SnackbarModifier: ViewModifier {
  @State private var animate = false
  @State private var timer: Timer?

  @Binding var show: Bool
  @Binding var restart: Bool
  let message: String
  var withCloseIcon: Bool

  public func body(content: Content) -> some View {
    ZStack {
      content

      if show {
        VStack {
          Spacer()

          HStack(spacing: Space.small) {
            Text(message)
              .typography(.body(color: YumeColor.inverseOnSurface))

            Spacer()

            if withCloseIcon {
              Button {
                hideSnackbar()
              } label: {
                IconView(
                  icon: Icons.close,
                  color: YumeColor.inverseOnSurface)
              }
            }
          }
          .foregroundColor(Color.white)
          .padding(Space.medium)
          .background(YumeColor.inverseSurface)
          .cornerRadius(Shape.extraSmall)
        }
        .padding(
          EdgeInsets(
            top: Space.small,
            leading: Space.medium,
            bottom: Space.small,
            trailing: Space.medium)
        )
        .animation(.easeInOut, value: animate)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .onAppear {
          animate = true
          startTimer()
        }
        .onDisappear {
          if restart {
            restart = false
            showSnackbar()
          }
        }
        .onChange(of: restart) { newRestart in
          if newRestart {
            hideSnackbar()
          }
        }
        .zIndex(100)
      }
    }

  }
}

extension SnackbarModifier {
  private func startTimer() {
    stopTimer()
    guard timer == nil else { return }
    timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
      hideSnackbar()
    }
  }

  private func stopTimer() {
    guard timer != nil else { return }
    timer?.invalidate()
    timer = nil
  }

  private func showSnackbar() {
    withAnimation(.easeInOut) {
      show = true
    }
    startTimer()
  }

  private func hideSnackbar() {
    withAnimation(.easeInOut) {
      show = false
    }
    stopTimer()
  }
}

extension View {
  public func snackbar(
    message: String,
    withCloseIcon: Bool = false,
    isShowing: Binding<Bool>,
    restart: Binding<Bool>) -> some View {
    self.modifier(SnackbarModifier(
      show: isShowing,
      restart: restart,
      message: message,
      withCloseIcon: withCloseIcon))
  }
}

private struct Snackbar: View {
  @State var showSnackbar = false
  @State var restartSnackbar = false

  var body: some View {
    VStack {
      Button("Show snackbar") {
        withAnimation(.easeInOut) {
          showSnackbar.toggle()
        }
      }.buttonStyle(.borderedProminent)
    }
    .snackbar(
      message: "Snackbar",
      withCloseIcon: true,
      isShowing: $showSnackbar,
      restart: $restartSnackbar)
  }
}

struct Snackbar_Previews: PreviewProvider {
  static var previews: some View {
    Snackbar()
  }
}

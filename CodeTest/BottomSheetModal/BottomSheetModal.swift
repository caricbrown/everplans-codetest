//
//  BottomSheetModal.swift
//  CodeTest
//
//  Created by Aric Brown on 5/17/21.
//

import SwiftUI

struct BottomSheetModal<Content: View>: View {
    @EnvironmentObject var bottomSheetState: BottomSheetState

    @StateObject private var keyboardHandler = KeyboardHandler()

    @State private var modalHeight: CGFloat = 395
    @State private var offset = CGSize.zero
    
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if bottomSheetState.isOpen {
                background
                modal
            }
        }
        .animation(.spring())
        .transition(.move(edge: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct BottomSheetModal_Previews: PreviewProvider {
    static var previews: some View {
        let bottomSheetState = BottomSheetState(isOpen: true)

        BottomSheetModal {
            CreatePost()
        }.environmentObject(bottomSheetState)
    }
}

final class BottomSheetState: ObservableObject {
    @Published var isOpen: Bool
    
    init(isOpen: Bool = false) {
        self.isOpen = isOpen
    }
}

extension BottomSheetModal {
    private var background: some View {
        Color.gray
            .fillParent()
            .opacity(0.65)
            .animation(.spring())
    }
    
    private var indicator: some View {
        Capsule()
            .fill(Color .handleColor)
            .frame(width: 32, height: 4)
            .padding(.vertical, 20)
    }
    
    private var modal: some View {
        VStack {
            indicator
            self.content
        }
        .frame(width: UIScreen.main.bounds.width, height: modalHeight, alignment: .top)
        .background(Color.white)
        .cornerRadius(16)
        .offset(y: (offset.height + 20))
        .gesture(
            DragGesture()
                .onChanged { value in self.onChangedDragValueGesture(value) }
                .onEnded { value in self.onEndedDragValueGesture(value) }
        )
        .transition(.move(edge: .bottom))
        .padding(.bottom, keyboardHandler.keyboardHeight)
        .animation(.default)
    }
    
    private func onChangedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height > 0 else { return }
        self.offset = value.translation
    }
    
    private func onEndedDragValueGesture(_ value: DragGesture.Value) {
        guard value.translation.height >= self.modalHeight / 2 else {
            self.offset = CGSize.zero
            return
        }
        
        withAnimation {
            bottomSheetState.isOpen.toggle()
            self.offset = CGSize.zero
        }
    }
}

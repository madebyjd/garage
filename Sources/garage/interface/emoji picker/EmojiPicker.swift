//
//  EmojiPicker.swift
//  
//
//  Created by Jonathan Danek on 5/11/23.
//

import SwiftUI
import Combine

#if os(iOS)
struct BlurEffectView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

#else

struct BlurEffectView: NSViewRepresentable
{
    public init(material: NSVisualEffectView.Material = .headerView, blendingMode: NSVisualEffectView.BlendingMode = .withinWindow) {
        self.material = material
        self.blendingMode = blendingMode
    }

    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode

    func makeNSView(context: Context) -> NSVisualEffectView
    {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = .windowBackground
        visualEffectView.blendingMode = blendingMode
        visualEffectView.isEmphasized = true
        visualEffectView.state = NSVisualEffectView.State.active
        return visualEffectView
    }

    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context)
    {
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
    }
}

#endif


public struct EmojiPicker: View {

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var emojis: [Emoji] {
        let search = search.trimmingCharacters(in: .whitespacesAndNewlines)
        if search.isEmpty {
            return Emoji.list()
                .filter { emoji in
                    let properties = emoji.value.unicodeScalars.map(\.properties)
                    
                    guard properties.first(where: \.isEmojiModifier) != nil || properties.first(where: \.isGraphemeBase) != nil  else { return false }

                    return properties.first(where: \.isEmoji) != nil
                }

        } else {
            return Emoji.list()
                .filter { $0.name.lowercased().contains(search.lowercased())
                }
        }
    }

    @Environment(\.dismiss)
    var dismiss

    @State
    public var selectedEmoji: Emoji?

    @State
    public var longSelectedEmoji: Emoji?

    @State
    private var search: String = ""

    @FocusState
    private var searchFocus: Bool

    @State
    private var searchHasFocus = false

    @State
    private var emojiOverlayTimer: AnyCancellable?

    @State
    private var offset: CGPoint = .init(x: 0.0, y: 60.0)

    @Environment(\.colorScheme) var colorScheme

    private let topInset: CGFloat = 60.0

    public init() {
        self._selectedEmoji = .init(initialValue: Emoji.list().randomElement())
    }

    public var body: some View {
        ZStack(alignment: .top) {

            ScrollView(.vertical){
                Spacer(minLength: topInset)
                    .frame(width: .infinity)

                emojisGrid
                    .padding( Constants.UI.medPadding)
            }

            header
                .background(Color.appDarkGray.opacity(0.95))
                .frame(height: 60.0)
                .topAlign()

        }

        .overlay {
            emojiNameAlert
                .hide(longSelectedEmoji == nil)

        }
    }

    var emojisGrid: some View {
        LazyVGrid(columns: columns) {

            ForEach(emojis, id: \.name) { emoji in
                ZStack {

                    RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                        .foregroundColor(.appLightGray)

                    RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                        .stroke(self.selectedEmoji?.value == emoji.value ? Color.accentColor : Color.clear, lineWidth: 4)
                        .foregroundColor(selectedEmoji?.value == emoji.value ? Color.clear : Color.appLightGray)

                    Text(String(Character(emoji.value)))
                        .font(.largeTitle)
                }
                .onTapGesture {
                    self.selectedEmoji = emoji
                    dismiss()
                }
                .onLongPressGesture(perform: {
                    self.longSelectedEmoji = emoji
                    emojiOverlayTimer = Timer.TimerPublisher.init(interval: 3.0, runLoop: RunLoop.main, mode: .common)
                        .autoconnect()
                        .sink() { _ in
                            emojiOverlayTimer?.cancel()
                            self.longSelectedEmoji = nil
                        }
                }, onPressingChanged: { _ in
                    emojiOverlayTimer?.cancel()
                    self.longSelectedEmoji = nil
                })
                .aspectRatio(1.0, contentMode: .fit)
                .help(emoji.name.capitalized)
            }
        }
    }

    var emojiNameAlert: some View {
        RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
            .foregroundColor(.appLightGray.opacity(0.85))
            .overlay {
                Text(longSelectedEmoji?.name.capitalized ?? "")
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding(10.0)
            }
            .padding(100.0)
            .aspectRatio(1.25, contentMode: .fit)
    }

    var header: some View {
        HStack(alignment: .center, spacing: Constants.UI.medPadding) {

            TextField("Search", text: $search)
                .textFieldStyle(RoundedTextFieldStyle(active: search.count > 0, color: Color.accentColor))
                .font(.title3)
                .focused($searchFocus)


            Button {
                dismiss()
            } label: {
                Text("Close")
                    .font(.title3)
            }
            .bold()
            .controlSize(ControlSize.regular)
        }
        .padding([.horizontal, .top], Constants.UI.largePadding)
        .topAlign()
    }
}

struct EmojiPicker_Previews: PreviewProvider {

    @State
    static var selectedEmoji: Emoji? = Emoji(value: "😃", name: "SMILING FACE WITH OPEN MOUTH")

    static var previews: some View {
        EmojiPicker()
            .accentColor(.orange)
            .refreshable {
                self._selectedEmoji = .init(wrappedValue: Emoji.list().randomElement()!)
            }
    }
}

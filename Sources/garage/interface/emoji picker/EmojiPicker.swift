//
//  EmojiPicker.swift
//  
//
//  Created by Jonathan Danek on 5/11/23.
//

import SwiftUI

public struct EmojiPicker: View {

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var emojis: [Emoji] {
        if search.isEmpty {
            return Emoji.list()
        } else {
            return Emoji.list()
                .filter { $0.name.lowercased().contains(search.lowercased()) }
        }
    }

    @Environment(\.dismiss)
    var dismiss

    @Binding
    public var selectedEmoji: Emoji?

    @State
    private var search: String = ""

    @FocusState
    private var searchFocus: Bool

    @State
    private var searchHasFocus = false

    private var selectedColor: Color

    public init(selectedEmoji: Binding<Emoji?>, selectedColor: Color) {
        self._selectedEmoji = selectedEmoji
        self.selectedColor = selectedColor
    }

    public var body: some View {
        ScrollView {

            VStack {
                HStack(alignment: .center, spacing: Constants.UI.medPadding) {

                    TextField("Search", text: $search)
                        .textFieldStyle(RoundedTextFieldStyle(active: search.count > 0))
                        .font(.title3)
                        .focused($searchFocus)


                    Button {
                        dismiss()
                        self.selectedEmoji = Emoji.list()[Int.random(in: 0..<600)]
                    } label: {
                        Text("Close")
                            .font(.title3)
                    }
                    .controlSize(ControlSize.regular)
                }
                .padding([.horizontal, .top], Constants.UI.largePadding)

                LazyVGrid(columns: columns) {
                    ForEach(emojis, id: \.name) { emoji in
                        ZStack {
                            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                                .onTapGesture {
                                    selectedEmoji = emoji
                                    dismiss()
                                }
                            Text(emoji.value)
                            }
                            .font(.largeTitle)
                            .foregroundColor(
                                selectedEmoji?.value == emoji.value ?
                                selectedColor : Color.appLightGray.opacity(0.25)
                            )
                            .aspectRatio(1.0, contentMode: .fit)
                            .help(emoji.name.capitalized)
                    }
                }
                .padding( Constants.UI.smallPadding)
            }
        }
    }
}

struct EmojiPicker_Previews: PreviewProvider {

    @State
    static var selectedEmoji: Emoji?

    static var previews: some View {
        EmojiPicker(selectedEmoji: $selectedEmoji, selectedColor: .orange)
            .onAppear {
                self.selectedEmoji = Emoji.list().first!
            }
    }
}

//
//  SwiftUIView.swift
//

import SwiftUI

struct TagView: View {

    var tag: Tag

    public init(tag: Tag) {
        self.tag = tag
    }

    var body: some View {
        Text(tag.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.vertical, 5.0)
            .padding(.horizontal, 10.0)
            .background(
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(tag.color)
            )
    }
}

struct TagView_Previews: PreviewProvider {
    static func genTag() -> Tag {
        Tag(title: Fake.Text.loremIpsumHeadline(number: 1))
    }

    static var previews: some View {
        TagView(tag: genTag())
    }
}

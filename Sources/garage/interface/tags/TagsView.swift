//
//  TagsView.swift
//

import SwiftUI

public struct TagsView: View {

    var tags: [Tag]

    public init(tags: [Tag]) {
        self.tags = tags
    }

    public var body: some View {
        HStack {
            ForEach(tags, id: \.title) { tag in
                TagView(tag: tag)
            }
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static func genTag() -> Tag {
        Tag(title: Fake.Text.loremIpsumHeadline(number: 1))
    }
    static var previews: some View {
        TagsView(
            tags: [
                genTag(),
                genTag(),
                genTag(),
                genTag()
            ]
        )
    }
}

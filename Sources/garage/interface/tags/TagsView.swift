//
//  TagsView.swift
//  
//
//  Created by Jonathan Danek on 5/5/23.
//

import SwiftUI

struct TagsView: View {
    var tags: [Tag]

    var body: some View {
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

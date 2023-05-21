//
//  DayView.swift
//
// Made from ideas/inspiration from `replicate - 7.png`

import Foundation
import SwiftUI

struct DayView<Content: View>: View {

    @State var selectedDay = Day.today

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                header

                DateScrollView(selectedDay: $selectedDay)

                content
            }
        }
    }

    var header: some View {
        HStack {
            Text(selectedDay.formatted(style: .medium))
                .font(.title2)

            Spacer()

            SymbolButton(systemName: "magnifyingglass") {

            }
            .aspectRatio(contentMode: .fit)
            .frame(height: 25.0)

            SymbolButton(systemName: "gear") {

            }
            .aspectRatio(contentMode: .fit)
            .frame(height: 25.0)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView {
            Text(Fake.Text.loremIpsumHeadline(number: 5))
                .font(.title)
                .bold()
                .leftAlign()
                .padding(5.0)
            Text(Fake.Text.loremIpsumSentences())
                .leftAlign()
                .padding(5.0)
            Text(Fake.Text.loremIpsumSentences())
                .leftAlign()
                .padding(5.0)
            Text(Fake.Text.loremIpsumSentences())
                .leftAlign()
                .padding(5.0)
        }
        .padding()
    }
}

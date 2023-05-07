//
//  SwiftUIView.swift
//  
//
//  Created by Jonathan Danek on 5/5/23.
//

import SwiftUI

struct DateScrollView: View {

    @State var selectedDay: Day

    @State var dates: [Day]

    internal init(selectedDay: State<Day>) {
        self._selectedDay = selectedDay

        if
            let upperDayBounds = selectedDay.wrappedValue.adding(months: 1, days: 14),
            let lowerDayBounds = selectedDay.wrappedValue.adding(days: -5) {

            self.dates = lowerDayBounds.daysTo(day: upperDayBounds)
        } else {
            self.dates = []
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack {
                    VStack {
                        Text("Load\nmore")
                            .fontWeight(.light)
                    }
                    .onTapGesture {
                        self.loadMoreLower()
                        proxy.scrollTo(50.0, anchor: .center)
                    }

                    ForEach(dates) { day in
                        VStack {
                            Text(day.makeDate()?.dayName.prefix(3) ?? "")
                                .font(.title2)
                                .fontWeight(.ultraLight)
                            ZStack {
                                Text("\(day.day)")
                                    .fontWeight(selectedDay != day ? .ultraLight : .bold)
                                    .foregroundColor(selectedDay != day ? .white : . black)
                                    .background(
                                        Circle()
                                            .foregroundColor(.init(white: 0.8))
                                            .frame(width: 19.0, height: 19.0)
                                            .isHidden(selectedDay != day)
                                    )
                            }
                        }
                        .onTapGesture {
                            self.selectedDay = day
                        }
                        .padding(0.0)
                    }
                    .padding(5.0)
                }
            }
        }
    }

    func loadMoreLower() {
        guard let upperBounds = self.dates.first, let lowerBounds = upperBounds.adding(months: -1) else { return }
        let dates = lowerBounds.daysTo(day: upperBounds)
        self.dates = dates + self.dates
    }
}

struct DateScrollView_Previews: PreviewProvider {
    @State static var day = Day.today

    static var previews: some View {
        DateScrollView(selectedDay: .init(initialValue: Day.today))
    }
}

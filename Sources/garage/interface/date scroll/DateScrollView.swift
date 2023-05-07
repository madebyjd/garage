//
//  SwiftUIView.swift
//  
//
//  Created by Jonathan Danek on 5/5/23.
//

import SwiftUI

struct DateScrollView: View {

    @Binding var selectedDay: Day

    @State var dates: [Day]

    init(selectedDay: Binding<Day>) {
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
                HStack(spacing: 0.0) {
                    VStack {
                        Text("Load\nmore")
                    }
                    .onTapGesture {
                        self.loadMoreLower()
                        proxy.scrollTo(50.0, anchor: .center)
                    }

                    ForEach(dates) { day in
                        if day.day == 1 {
                            Text(day.nameOfMonth(style: .full))
                                .font(.largeTitle)
                                .fontWeight(.thin)
                                .frame(height: 15.0)
                        } else {
                            Text("")
                                .frame(height: 15.0)
                        }
                        dayView(for: day)
                            .padding(5.0)
                            .onTapGesture {
                                self.selectedDay = day
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .foregroundColor(
                                        .today != day ? .white.opacity(0.01) : Color.accentColor.opacity(0.2)
                                    )
                            )
                            .padding(0.0)
                    }
                    .padding(5.0)
                }
            }
        }
    }

    func dayView(for day: Day) -> some View {
        VStack {
            Text(day.makeDate()?.dayName.prefix(3) ?? "")
                .font(.title2)
                .fontWeight(.light)
            ZStack {
                Text("\(day.day)")
                    .fontWeight(selectedDay != day ? .regular : .bold)

                    .foregroundColor(selectedDay != day ? .primary : .white)
                    .background(
                        Circle()
                            .foregroundColor(.accentColor)
                            .frame(width: 20.0, height: 20.0)
                            .isHidden(selectedDay != day)
                    )
            }
        }
    }

    func loadMoreLower() {
        guard let upperBounds = self.dates.sorted(by: { lhs, rhs in
            lhs < rhs
        }).first, let lowerBounds = upperBounds.adding(days: -28) else { return }
        let dates = lowerBounds.daysTo(day: upperBounds)

        self.dates = (dates + self.dates)

        self.dates = self.dates
            .removeDuplicates()
            .sorted()
    }
}

struct DateScrollView_Previews: PreviewProvider {
    static var day = Day.today

    static var previews: some View {
        DateScrollView(selectedDay: .init(get: {
            day
        }, set: { newDay in
            self.day = newDay
        }))
    }
}

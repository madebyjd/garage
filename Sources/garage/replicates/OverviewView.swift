//
//  OverviewView.swift
//
// Made from ideas/inspiration from `replicate - 2.png`

import SwiftUI

struct OverviewViewModel {

    var symbol: String
    var title: String
    var subtitle: String

    var description: String

    var details: [String: String]
}

struct OverviewView: View {

    var model: OverviewViewModel

    var body: some View {
        VStack {
            header

            details
        }
        .padding()
    }

    var header: some View {
        HStack {
            ZStack {
                Circle()
                Image(systemName: model.symbol)
                    .foregroundColor(.white)
                    .font(.title)
            }
            .frame(width: 60.0, height: 60.0)
            VStack {
                Text(model.title)
                    .fontWeight(.medium)
                    .leftAlign()
                Text(model.subtitle)
                    .foregroundColor(.accentColor)
                    .leftAlign()
            }
        }
    }

    var details: some View {
        HStack(alignment: .top) {
            VStack(spacing: 5.0) {
                ForEach(Array(model.details.keys).prefix(4), id: \.self) { key in
                    KeyValueView(key: key, value: model.details[key] ?? "", color: .accentColor)
                }
            }

            VStack(spacing: 5.0) {
                ForEach(Array(model.details.keys).dropFirst(4), id: \.self) { key in
                    KeyValueView(key: key, value: model.details[key] ?? "", color: .accentColor)
                }
            }
        }
        .padding(5.0)
        .background(
            RoundedRectangle(cornerRadius: 5.0)
                .foregroundColor(.gray.opacity(0.05))
        )
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView(
            model: OverviewViewModel(
                symbol: "figure.walk",
                title: Fake.Text.loremIpsumHeadline(number: 3),
                subtitle: Fake.Text.loremIpsumHeadline(number: 3),
                description: Fake.Text.loremIpsumHeadline(number: 8),
                details: [
                    "Workout Time": "0:37:25",
                    "Distance": "1.61 Miles",
                    "Active Calories": "169 Cal",
                    "Total Calories": "224 Cal",
                    "Elevation Gain": "105 Ft",
                    "Avg. Pace": "23'10",
                    "Avg. Heart Rate": "103 Bpm"
                ]
            )
        )
    }
}

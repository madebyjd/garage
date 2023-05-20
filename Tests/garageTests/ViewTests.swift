//
//  ViewTests.swift
//  
//
//  Created by Jonathan Danek on 5/19/23.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import garage

final class ViewTests: XCTestCase {

    func testDayView() throws {

        let sut = DayView {
            EmptyView()
        }

        let text = try sut.inspect().find(text: "\(Day.today.day)").string()
        XCTAssert(!text.isEmpty)
    }

    func testOverviewView() throws {

        let model = OverviewViewModel(symbol: "hare.fill", title: "title", subtitle: "subtitle", description: "just some description", details: ["key" : "value"])
        let sut = OverviewView(model: model)

        let text = try sut.inspect().find(text: "title").string()
        XCTAssert(!text.isEmpty)
    }
}

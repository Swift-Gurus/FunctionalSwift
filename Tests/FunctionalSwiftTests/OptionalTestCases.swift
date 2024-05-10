@testable import AHFunctionalSwift
import XCTest

final class OptionalTestCases: XCTestCase {
    func test_filter_returns_some_if_matches() {
        XCTAssertEqual(Optional(10).filter { $0 == 10 },
                       10)
    }

    func test_filter_returns_nil_if_doent_matche() {
        XCTAssertNil(Optional(10).filter { $0 == 1 })
    }

    func test_filter_is_not_called_on_none() {
        XCTAssertNil(
            Optional(nil).filter {
                XCTFail("Should not be called")
                return true
            }
        )
    }

    func test_filter_with_default_returns_some_if_matches() {
        XCTAssertEqual(Optional(10).filter(default: 1) { $0 == 10 },
                       10)
    }

    func test_filter_returns_default_if_doent_matche() {
        XCTAssertEqual(Optional(10).filter(default: 1) { $0 == 20 },
                       1)
    }

    func test_filter_with_default_is_not_called_on_none() {
        XCTAssertNil(Int?(nil).filter(default: 1) { _ in
            XCTFail("Should not be called")
            return true
        })
    }

    func test_performs_do_if_some() {
        var value = 0
        Optional(10).do { value = $0 }
        XCTAssertEqual(value, 10)
    }

    func test_doesnt_perform_do_if_none() {
        var value = -1
        Optional(nil).do { value = $0 }
        XCTAssertEqual(value, -1)
    }

    func test_doesnt_perform_on_none_if_none() {
        var value = 0
        Optional(10).onNone { value = 10 }
        XCTAssertEqual(value, 0)
    }

    func test_performs_on_none_if_none() {
        var value = -1
        Int?(nil).onNone { value = 10 }
        XCTAssertEqual(value, 10)
    }
}

@testable import FunctionalSwift
import XCTest

class ALResultTestCases: XCTestCase {
    private var tester = ResultTester()

    func test_result_initialized_from_value() {
        let str = "Test"
        ALResult(str).testResultIsSuccess(expectedValue: str)
    }

    func test_result_do_is_called() {
        var result = ""
        let initial = "Test"
        ALResult(initial).do { result = $0 }
        XCTAssertEqual(result, initial)
    }

    func test_result_initialized_from_error() {
        let error = MockError.notFound
        ALResult<String>(error).testResultIsFailure(expectedError: error)
    }

    func test_returns_error_if_value_and_error_passed_into_init() {
        let str = "Test"
        let error = MockError.notFound
        ALResult(success: str, error: error).testResultIsFailure(expectedError: error)
    }

    func test_map_converts_if_restul_is_right() {
        ALResult(10)
            .map { "\($0)" }
            .testResultIsSuccess(expectedValue: "10")
    }

    func test_map_is_skipped_if_restul_is_wrong() {
        let error = MockError.notFound
        ALResult<Int>(error)
            .map { "\($0)" }
            .testResultIsFailure(expectedError: error)
    }

    func test_map_throws_error_should_end_up_with_wrong() {
        let error = MockError.notFound
        let mapFunction: (Int) throws -> String = { _ in  throw error }
        ALResult(10)
            .tryMap(mapFunction)
            .testResultIsFailure(expectedError: error)
    }

    func test_try_map_is_not_called_for_failed_state() {
        let initial = ALResult<Int>.failure(MockError.notFound)
        let mapFunction: (Int) throws -> String = { value in
            XCTFail("should not be called")
            return "My number \(value)"
        }
        initial
            .tryMap(mapFunction)
            .testResultIsFailure(expectedError: MockError.notFound)
    }

    func test_init_selects_error_state_if_both_provided() {
        ALResult(success: "", error: MockError.notFound).testResultIsFailure(expectedError: MockError.notFound)
    }

    func test_init_selects_success() {
        ALResult(success: "Hello", error: nil).testResultIsSuccess(expectedValue: "Hello")
    }

    func test_init_selects_returns_generic_error_if_nothing_provided() {
        let expectedError = NSError(
            domain: "ALResult",
            code: -1,
            userInfo: ["msg": "Couldn't create monad out of 2 optionals"]
        )
        ALResult<String>(success: nil, error: nil).testResultIsFailure(expectedError: expectedError)
    }

    func test_result_is_equal() {
        let result = Result<String, MockError>.success("test")
        tester.testResultIsEqual(result: result, expectedResult: .success("test"))
    }

    func test_result_is_not_equal() {
        let result = Result<String, MockError>.success("test")
        tester.testResultIsNotEqual(result: result, expectedResult: .success("tes"))
    }

    func test_sink_calls_the_passed_closure() {
        var receivedResult: ALResult<String>?
        ALResult(10).map { "\($0)" }.sink { receivedResult = $0 }
        XCTAssertNotNil(receivedResult)
    }

    func test_performs_function_on_error() {
        let result = ALResult<String>(success: nil, error: MockError.notFound)
        var receivedValue = ""
        result.onError { _ in  receivedValue = "new" }
        XCTAssertEqual(receivedValue, "new")
        result.testResultIsFailure(expectedError: MockError.notFound)
    }

    func test_do_try_converts_into_error_when_throws() {
        let expectedError = MockError.notFound
        ALResult(10).doTry { _ in throw expectedError }
                    .testResultIsFailure(expectedError: expectedError)
    }

    func test_do_try_retruns_self_when_no_error_thrown() {
        ALResult(10).doTry { print($0) }
                    .testResultIsSuccess(expectedValue: 10)
    }

    func test_try_flat_map_returns_new_flatten_result() {
        ALResult(10).tryFlatMap { .success("\($0)") }
                    .testResultIsSuccess(expectedValue: "10")
    }

    func test_try_flat_map_returns_failure_if_an_error_thrown() {
        let expectedError = MockError.notFound
        let new: ALResult<String> = ALResult(10).tryFlatMap { _ in throw expectedError }
        new.testResultIsFailure(expectedError: expectedError)
    }

    func test_failure_doesnt_call_try_flat_map() {
        let initial = ALResult<Int>(success: nil, error: MockError.notFound)
        let new: ALResult<String> = initial.tryFlatMap { value in
            XCTFail("Function should not be called")
            return .success("\(value)")
        }
        new.testResultIsFailure(expectedError: MockError.notFound)
    }
}

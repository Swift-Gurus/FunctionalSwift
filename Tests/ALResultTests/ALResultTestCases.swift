//
//  ALResultTestCases.swift
//  ALResult_Tests
//
//  Created by Alex Hmelevski on 2018-05-23.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import ALResult

class ALResultTestCases: XCTestCase {
    
    var tester = ResultTester()
    
    func test_result_initialized_from_value() {
        let str = "Test"
        ALResult(str).testResultIsRight(expectedValue: str)                                
    }
    
    
    func test_result_initialized_from_error() {
        let error = MockError.notFound
        ALResult<String>(error).testResultIsWrong(expectedError: error)
    }
    
    func test_returns_error_if_value_and_error_passed_into_init() {
        let str = "Test"
        let error = MockError.notFound
        ALResult(value: str, error: error).testResultIsWrong(expectedError: error)
    }
    
    func test_map_converts_if_restul_is_right() {
        ALResult(10).map({"\($0)"})
                    .testResultIsRight(expectedValue: "10")
    }
    
    func test_map_is_skipped_if_restul_is_wrong() {
        let error = MockError.notFound
        ALResult<Int>(error).map({"\($0)"})
                            .testResultIsWrong(expectedError: error)
    }
    
    func test_map_throws_error_should_end_up_with_wrong() {
        let error = MockError.notFound
        let mapFunction: (Int) throws -> String =  {_ in  throw error }
        ALResult(10).map(mapFunction)
                    .testResultIsWrong(expectedError: error)
    }
    
    func test_passed_filter_returns_original_value() {
        ALResult(10).filter({$0 > 0}, default: 0)
                    .testResultIsRight(expectedValue: 10)
    }
    
    func test_passed_failed_returns_default_value() {
        ALResult(10).filter({$0 < 0}, default: 0)
            .testResultIsRight(expectedValue: 0)
    }
    
    func test_filter_is_bypassed_for_wrong() {
        let error = MockError.notFound
        ALResult<Int>(error).filter({$0 > 0}, default: 0)
                            .testResultIsWrong(expectedError: error)
    }
    
    func test_result_is_equal() {
        let result = ALResult.right("test")
        tester.testResultIsEqual(result: result, expectedResult: .right("test"))
    }
    
    func test_result_is_not_equal() {
        let result = ALResult.right("test")
        tester.testResultIsNotEqual(result: result, expectedResult: .right("tes"))
    }
}

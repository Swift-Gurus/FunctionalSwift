//
//  ResultTester.swift
//  ALResult_Tests
//
//  Created by Alex Hmelevski on 2018-05-25.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

import XCTest
@testable import ALResult


extension Result where Success: Equatable, Failure == Error {
    func testResultIsRight(expectedValue: Success,
                           file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(value): XCTAssertEqual(expectedValue, value, file: file, line: line)
        default: XCTFail("Expect Success ", file: file, line: line)
        }
    }
    
    func testResultIsWrong(expectedError: Error,
                           file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .failure(error):
            XCTAssertEqual(expectedError.localizedDescription, error.localizedDescription, file: file, line: line)
        default: XCTFail("Expect Success ", file: file, line: line)
        }
    }
}

enum MockError: Error {
    case notFound
}

final class ResultTester {
    func testResultIsRight<T: Equatable>(result: ALResult<T>,
                                         expectedValue: T,
                                         file: StaticString = #file, line: UInt = #line) {
        
        switch result {
        case let .success(value): XCTAssertEqual(expectedValue, value, file: file, line: line)
        default: XCTFail("Expect Success ", file: file, line: line)
        }
    }
    
    func testResultIsWrong<T: Equatable>(result: ALResult<T>,
                                         expectedError: Error,
                                         file: StaticString = #file, line: UInt = #line) {
        switch result {
        case let .failure(error):
            XCTAssertEqual(expectedError.localizedDescription, error.localizedDescription, file: file, line: line)
        default: XCTFail("Expect Success ", file: file, line: line)
        }
    }
    
    func testResultIsEqual<T: Equatable, E: Equatable>(result: Result<T,E>,
                                                       expectedResult: Result<T,E>,
                                                       file: StaticString = #file, line: UInt = #line)  {
        XCTAssertEqual(result, expectedResult, file: file, line: line)
    }
    
    func testResultIsNotEqual<T: Equatable, E: Equatable>(result: Result<T,E>,
                                                          expectedResult: Result<T,E>,
                                                          file: StaticString = #file, line: UInt = #line){
        XCTAssertNotEqual(result, expectedResult, file: file, line: line)
    }
}

//
//  ALResult.swift
//  ALResult
//
//  Created by Alex Hmelevski on 2018-05-23.
//

import Foundation
public typealias ALResult<T> = Result<T, Error>
public typealias ResultClosure<T> = Closure<ALResult<T>>
public typealias Closure<T> = (T) -> Void
 

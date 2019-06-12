//
//  NetworkResult.swift
//  NetworkSeminar
//
//  Created by wookeon on 28/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

enum NetworkResult<T> {
    // 통신의 상태에 대한 분기 코드입니다.
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

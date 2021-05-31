//
//  FirmwareService.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation
import Moya

enum FirmwareEndpoint {
    case getFirmwares
}

// MARK: - TargetType Protocol Implementation
extension FirmwareEndpoint: TargetType {
    
    var baseURL: URL { return URL(string: Constants.statusServerURL)! }
    var path: String {
        switch self {
        case .getFirmwares:
            return "/firmwares"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getFirmwares:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getFirmwares:
            return .requestPlain // Send no parameters
        }
    }
        
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
        
    var headers: [String: String]? {
        return ["Content-type": "application/json",
                "Authorization": "Bearer \(Constants.statusServerAPIKey)"]
    }
}

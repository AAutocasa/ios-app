//
//  DeviceService.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//
import Foundation
import Moya

enum DeviceService {
    case getDevices
    case getDevice(byId: String)
    
    case deleteDevice(withId: String)
    
    case setDeviceRole(deviceId: String, roleCode: Int)
    case activateDevice(deviceId: String)
    case deactivateDevice(deviceId: String)
    
    case updateDevice(deviceId: String, tag: String?, group: String?, location: String?)
}

// MARK: - TargetType Protocol Implementation
extension DeviceService: TargetType {
    
    var baseURL: URL { return URL(string: Constants.statusServerURL)! }
    var path: String {
        switch self {
        case .getDevices:
            return "/devices"
            
        case .getDevice(let id),
             .deleteDevice(let id):
            return "/devices/\(id)"
            
        case .setDeviceRole(let id, _):
            return "/devices/\(id)/role"
            
        case .activateDevice(let id):
            return "/devices/\(id)/activate"
            
        case .deactivateDevice(let id):
            return "/devices/\(id)/deactivate"
            
        case .updateDevice(let id, _, _, _):
            return "/devices/\(id)/infos"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getDevices, .getDevice:
            return .get
            
        case .deleteDevice:
            return .delete
            
        case .setDeviceRole,
             .activateDevice,
             .deactivateDevice,
             .updateDevice:
            return .put
        }
    }
    var task: Task {
        switch self {
        case .getDevices,
             .getDevice,
             .deleteDevice,
             .activateDevice,
             .deactivateDevice:
            return .requestPlain // Send no parameters
        
        case .setDeviceRole(_, let roleCode):
            return .requestParameters(parameters: ["role": roleCode], encoding: JSONEncoding.default) // Send on request Bbody
        
        case .updateDevice(_, let tag, let group, let location):
            var parameters: [String: Any] = [:]
            
            if let tag = tag {
                parameters["tag"] = tag
            }
            if let group = group {
                parameters["group"] = group
            }
            if let location = location {
                parameters["location"] = location
            }
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default) // Send on request Bbody
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
    
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

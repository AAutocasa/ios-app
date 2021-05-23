//
//  DeviceWorker.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 23/05/21.
//

import Foundation
import Combine

protocol DeviceWorker: AnyObject {
    func fetchDevices() -> AnyPublisher<[Device], Error>
    func fetchDevice(with id: UUID) -> AnyPublisher<Device, Error>
    func activate(_ device: Device) -> AnyPublisher<Device, Error>
    func deactivate(_ device: Device) -> AnyPublisher<Device, Error>
}

class DefaultDeviceWorker: DeviceWorker {
    func fetchDevices() -> AnyPublisher<[Device], Error> {
        let url = URL(string: "http://localhost:4000/devices")!
        
        let token = "8s2bs81s21bn8s2dj49fm49igndsng9n329d"
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        print("Starting request...")

        return URLSession.shared.dataTaskPublisher(for: request)
            .filter({ _ in
                print("aaa")
                return true
            })
            .map { $0.data }
            .filter({ _ in
                print("bbb")
                return true
            })
            .decode(type: [Device].self, decoder: JSONDecoder())
            .filter({ _ in
                print("ccc")
                return true
            })
            .eraseToAnyPublisher()
    }
    
    func fetchDevice(with id: UUID) -> AnyPublisher<Device, Error> {
        let url = URL(string: "rotaParaPegarUmDevice")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Device.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func activate(_ device: Device) -> AnyPublisher<Device, Error> {
        let url = URL(string: "rotaParaAtivarUmDevice")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Device.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func deactivate(_ device: Device) -> AnyPublisher<Device, Error> {
        let url = URL(string: "rotaParaDesativarUmDevice")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Device.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}

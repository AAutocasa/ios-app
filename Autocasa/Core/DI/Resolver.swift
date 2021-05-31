//
//  Resolver.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 27/05/21.
//

import Foundation
import Swinject

class Resolver {
    static let shared = Resolver()
    private lazy var container = buildContainer()

    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
    
    func buildContainer() -> Container {
        let container = Container()
        buildDeviceContainer(container)
        buildFirmwareContainer(container)
        return container
    }
    
    func buildDeviceContainer(_ container: Container) {
        container.register(DeviceService.self) { _  in
            return APIDeviceService()
        }.inObjectScope(.container)
        
        container.register(DeviceRepository.self) { _  in
            return DefaultDeviceRepository()
        }.inObjectScope(.container)
    }
    
    func buildFirmwareContainer(_ container: Container) {
        container.register(FirmwareService.self) { _  in
            return DefaultFirmwareService()
        }.inObjectScope(.container)
        
        container.register(FirmwareRepository.self) { _  in
            return DefaultFirmwareRepository()
        }.inObjectScope(.container)
    }

}

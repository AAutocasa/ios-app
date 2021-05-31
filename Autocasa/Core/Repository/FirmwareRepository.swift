//
//  FirmwareRepository.swift
//  Autocasa
//
//  Created by André Schueda on 31/05/21.
//

import Foundation
import Combine

protocol FirmwareRepository {
    func fetchFirmwares() -> AnyPublisher<[Firmware], Error>
    func fetchFirmware(with code: Int) -> AnyPublisher<Firmware, Error>
    func fetchFirmwareRole(with code: Int) -> AnyPublisher<FirmwareRole, Error>
}

class DefaultFirmwareRepository: FirmwareRepository {
    
    
    @Inject private var firmwareService: FirmwareService
    
    private let cache = Cache<Int, Firmware>(
        identifiedBy: { $0.code },
        expirationTime: 600)
    
    func fetchFirmwares() -> AnyPublisher<[Firmware], Error> {
        print("[FirmwareRepository] Fetching all firmwares...")
        if cache.isValid {
            print("[DeviceRepository] Cache is valid! Returning cache")
            return Just(cache.get())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        print("[FirmwareRepository] Cache invalid. Querying...")
        return firmwareService.fetchFirmwares()
            .handleOutput { [weak self] firmwares in
                self?.cache.update(firmwares)
                self?.cache.clear()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchFirmware(with code: Int) -> AnyPublisher<Firmware, Error> {
        fetchFirmwares()
            .tryMap {
                guard let firmware = $0.first(where: { $0.code == code }) else {
                    throw FirmwareErrors.invalidFirmwareCode
                }
                return firmware
            }
            .eraseToAnyPublisher()
    }
    
    func fetchFirmwareRole(with code: Int) -> AnyPublisher<FirmwareRole, Error> {
        fetchFirmwares()
            .tryMap {
                let roles = $0.flatMap({ $0.possibleRoles })
                guard let firmwareRole = roles.first(where: { $0.code == code }) else {
                    throw FirmwareErrors.invalidFirmwareRoleCode
                }
                return firmwareRole
            }
            .eraseToAnyPublisher()
    }
}


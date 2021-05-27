//
//  Cache.swift
//  Autocasa
//
//  Created by Enzo Maruffa Moreira on 27/05/21.
//

import Foundation

public class Cache<K: Hashable, M> {
    
    typealias Identification = (M) -> K
    typealias Unit = CachedUnit<K, M>
    
    fileprivate var units: [K: Unit] = [:]
    fileprivate let identifiedBy: Identification
    
    var isValid: Bool {
        !units.isEmpty
            && units.values
                .filter({ !$0.isValid(maxExpiration: expirationTime) })
                .isEmpty // Guarantees no unit is invalid
    }
    
    let expirationTime: TimeInterval // in seconds
    
    internal init(identifiedBy: @escaping Cache<K, M>.Identification, expirationTime: TimeInterval) {
        self.identifiedBy = identifiedBy
        self.expirationTime = expirationTime
    }
    
    func get() -> [M] {
        units.values.map{ $0.value }
    }
    
    func get(withKey key: K) -> M? {
        units[key]?.value
    }
    
    func invalidate(withKey key: K) {
        units[key]?.invalidate()
    }
    
    func update(_ value: M) {
        let key = identifiedBy(value)
        if units[key] == nil {
            let unit = CachedUnit<K, M>(value: value)
            units[key] = unit
        } else {
            units[key]?.value = value
        }
    }
    
    func update(_ values: [M]) {
        values.forEach { update($0) }
    }
    
    // Removes all invalid
    func clear() {
        units.keys.forEach { key in
            if let unit = units[key],
               !unit.isValid(maxExpiration: expirationTime) {
                units.removeValue(forKey: key)
            }
        }
    }
    
    
}

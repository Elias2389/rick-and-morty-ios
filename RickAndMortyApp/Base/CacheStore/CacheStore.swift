//
//  CacheStore.swift
//  RickAndMortyApp
//
//  Created by Andres Rivas on 27/06/2024.
//

import Foundation

protocol CacheStoreDataSource {
    associatedtype Key: Hashable
    associatedtype Value
    
    func save(_ value: Value, forkey key: Key)
    func retrieve(forkey key: Key) -> Value?
    func removeValue(forkey key: Key)
    
    subscript(key: Key) -> Value? { get set }
}

public class CacheStoreDataSoruceImpl<Key: Hashable, Value>: CacheStoreDataSource {
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    public func save(_ value: Value, forkey key: Key) {
           let entry = Entry(value: value)
           wrapped.setObject(entry, forKey: WrappedKey(key))
       }
       
    public func retrieve(forkey key: Key) -> Value? {
           let entry = wrapped.object(forKey: WrappedKey(key))
           return entry?.value
       }
       
    public func removeValue(forkey key: Key) {
           wrapped.removeObject(forKey: WrappedKey(key))
       }
}

private extension CacheStoreDataSoruceImpl {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }
}

private extension CacheStoreDataSoruceImpl {
    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}

public extension CacheStoreDataSoruceImpl {
     subscript(key: Key) -> Value? {
         get { return retrieve(forkey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                removeValue(forkey: key)
                return
            }
            save(value, forkey: key)
        }
    }
}

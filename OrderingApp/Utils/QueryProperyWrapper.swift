//
//  QueryProperyWrapper.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 04/07/22.
//

import Foundation
import SwiftUI


/// A Property Wrapper type that can execute a given fetch function that returns an array of Identifiable objects and provide useful state of the query.
@propertyWrapper
struct Query<Value>: DynamicProperty {
    @State private var isLoading: Bool = true
    @State private var error: Error? = nil
    @State private var isFetched = false
    
    @State var wrappedValue: Value
    
    var projectedValue: (isLoading: Bool, error: Error?, refetch: () -> (), bindingValue: Binding<Value>) {
        Task {
            if (!isFetched) {
                do {
                    withAnimation {
                        isLoading = true
                    }
                    let result =  try await query()
                    withAnimation {
                        wrappedValue =  result
                        isLoading = false
                    }
                    isFetched = true
                }
                catch {
                    print("Error fetching Query: ", query.self, error)
                    self.error = error
                    isLoading = false
                    isFetched = true
                }
            }
        }
        return (isLoading, error, refetch, $wrappedValue)
    }
    
    /// Initializer for the Query property wrapper.
    /// - Parameters:
    ///   - wrappedValue: the default value of the array
    ///   - query: an async throws function returning an Array of Identifiable objects or structs
    init (wrappedValue: Value, query: @escaping () async throws -> Value) {
        self._wrappedValue = State(initialValue: wrappedValue)
        self.query = query
    }
    
    /// Executes the given query to update the data
    func refetch() {
        error = nil
        isFetched = false
    }
    
    var query: () async throws -> Value
}

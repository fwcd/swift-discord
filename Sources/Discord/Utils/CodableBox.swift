/// An immutable container storing a wrapped value on
/// the heap. This is useful when a codable value type
/// recursively may contain itself.
@propertyWrapper
public class CodableBox<Value>: Codable where Value: Codable {
    public let wrappedValue: Value

    public required init(from decoder: Decoder) throws {
        wrappedValue = try Value.init(from: decoder)
    }

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension CodableBox: Equatable where Value: Equatable {
    public static func ==(lhs: CodableBox<Value>, rhs: CodableBox<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

extension CodableBox: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        wrappedValue.hash(into: &hasher)
    }
}

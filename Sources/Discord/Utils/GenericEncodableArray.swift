/// Swift normally doesn't allow `[Encodable]` to be encoded
struct GenericEncodableArray: Encodable {
    let wrapped: [Any]

    init(_ wrapped: [Any]) {
        self.wrapped = wrapped
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for item in wrapped {
            let superEncoder = container.superEncoder()
            switch item {
            case let array as [Any]:
                try GenericEncodableArray(array).encode(to: superEncoder)
            case let dictionary as [String: Any]:
                try GenericEncodableDictionary(dictionary).encode(to: superEncoder)
            case let item as Encodable:
                try item.encode(to: superEncoder)
            default:
                throw EncodingError.invalidValue(item, .init(codingPath: encoder.codingPath, debugDescription: "Attempted to encode a value that doesn't conform to encodable"))
            }
        }
    }
}

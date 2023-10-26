/// Swift normally doesn't allow `[String: Encodable]` to be encoded
struct GenericEncodableDictionary : Encodable {
    let wrapped: [String: Any]

    private struct GenericEncodingKey : CodingKey {
        var stringValue: String
        var intValue: Int? { return nil }

        init(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            return nil
        }
    }

    init(_ wrapped: [String: Any]) {
        self.wrapped = wrapped
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenericEncodingKey.self)
        for (key, value) in wrapped {
            let superEncoder = container.superEncoder(forKey: GenericEncodingKey(stringValue: key))
            switch value {
            case let array as [Any]:
                try GenericEncodableArray(array).encode(to: superEncoder)
            case let dictionary as [String: Any]:
                try GenericEncodableDictionary(dictionary).encode(to: superEncoder)
            case let value as Encodable:
                try value.encode(to: superEncoder)
            default:
                throw EncodingError.invalidValue(value, .init(codingPath: encoder.codingPath, debugDescription: "Attempted to encode a value that doesn't conform to encodable"))
            }
        }
    }
}

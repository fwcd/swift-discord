extension KeyedDecodingContainerProtocol {
    func decodePrimitiveAny(forKey key: Key) throws -> Any {
        if let b = try? decode(Bool.self, forKey: key) {
            return b
        } else if let i = try? decode(Int.self, forKey: key) {
            return i
        } else if let s = try? decode(String.self, forKey: key) {
            return s
        } else if let d = try? decode(Double.self, forKey: key) {
            return d
        } else {
            throw DecodingError.typeMismatch(Any.self, .init(
                codingPath: codingPath,
                debugDescription: "Could not decode primitive any",
                underlyingError: nil
            ))
        }
    }
}

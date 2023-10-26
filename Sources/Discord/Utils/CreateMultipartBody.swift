import Foundation

func createMultipartBody(encodedJSON: Data, files: [DiscordFileUpload]) -> (boundary: String, body: Data) {
    let boundary = "Boundary-\(UUID())"
    let crlf = "\r\n".data(using: .utf8)!
    var body = Data()

    body.append("--\(boundary)\r\n".data(using: .utf8)!)
    body.append("Content-Disposition: form-data; name=\"payload_json\"\r\n".data(using: .utf8)!)
    body.append("Content-Type: application/json\r\n".data(using: .utf8)!)
    body.append("Content-Length: \(encodedJSON.count)\r\n\r\n".data(using: .utf8)!)
    body.append(encodedJSON)
    body.append(crlf)

    for (index, file) in files.enumerated() {
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\(index)\"; filename=\"\(file.filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(file.mimeType)\r\n".data(using: .utf8)!)
        body.append("Content-Length: \(file.data.count)\r\n\r\n".data(using: .utf8)!)
        body.append(file.data)
        body.append(crlf)
    }

    body.append("--\(boundary)--\r\n".data(using: .utf8)!)

    return (boundary, body)
}

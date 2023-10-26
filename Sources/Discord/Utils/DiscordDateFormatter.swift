import Foundation

// Enum for namespacing
enum DiscordDateFormatter {
    private static let fractionalSecondsFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    private static let wholeSecondsFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    static func date(from string: String) -> Date? {
        return DiscordDateFormatter.fractionalSecondsFormatter.date(from: string)
            ?? DiscordDateFormatter.wholeSecondsFormatter.date(from: string)
    }

    static func string(from date: Date) -> String {
        return DiscordDateFormatter.fractionalSecondsFormatter.string(from: date)
    }
}

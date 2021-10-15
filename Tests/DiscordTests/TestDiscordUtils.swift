import XCTest
@testable import Discord

public class TestDiscordUtils: XCTestCase {
    func testISO8601DateParsing() {
        // The parser should be able to handle both with and without fractional seconds
        let raw1 = "2021-09-20T13:14:01+00:00"
        let raw2 = "2021-09-20T13:14:01.000000+00:00"

        let date1 = DiscordDateFormatter.date(from: raw1)
        let date2 = DiscordDateFormatter.date(from: raw2)
        XCTAssertNotNil(date1)
        XCTAssertEqual(date1, date2)
    }
}

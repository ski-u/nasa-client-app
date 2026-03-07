import Foundation

public enum DateFormatStyles {
    public static let iso8601YearMonthDayUTC = Date.ISO8601FormatStyle(timeZone: .gmt)
        .year()
        .month()
        .day()
}

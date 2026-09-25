public enum JapaneseKanaNumberFormatStyleConfiguration {
    struct Collection: Codable, Hashable, Sendable {
        var grouping: Grouping?
    }

    /// A structure that a Japanese kana number format style uses to configure grouping.
    public struct Grouping: Codable, Hashable, Sendable {
        /// A grouping behavior that inserts the specified separator between places.
        public static func place(separator: String) -> Self {
            Self(placeSeparator: separator)
        }

        /// A grouping behavior that does not group parts of the output.
        public static var never: Self {
            Self(placeSeparator: nil)
        }

        let placeSeparator: String?
    }
}

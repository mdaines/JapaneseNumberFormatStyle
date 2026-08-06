import Testing
@testable import JapaneseNumberFormatStyle

@Suite struct JapaneseKanaNumberFormatStyleTests {
    @Test func formatted() async throws {
        let expected = "ひゃくにじゅうさん"

        #expect(Int(123).formatted(.japaneseKana) == expected)
        #expect(Int16(123).formatted(.japaneseKana) == expected)
        #expect(Int32(123).formatted(.japaneseKana) == expected)
        #expect(Int64(123).formatted(.japaneseKana) == expected)
        #expect(Int8(123).formatted(.japaneseKana) == expected)
        #expect(UInt(123).formatted(.japaneseKana) == expected)
        #expect(UInt16(123).formatted(.japaneseKana) == expected)
        #expect(UInt32(123).formatted(.japaneseKana) == expected)
        #expect(UInt64(123).formatted(.japaneseKana) == expected)
        #expect(UInt8(123).formatted(.japaneseKana) == expected)
    }

    @Test func format() async throws {
        let formatStyle = JapaneseKanaNumberFormatStyle<Int>()

        #expect(formatStyle.format(123) == "ひゃくにじゅうさん")
        #expect(formatStyle.format(-3) == "マイナスさん")
        #expect(formatStyle.format(0) == "ゼロ")
    }

    @Test func minMax() async throws {
        #expect(Int.min.formatted(.japaneseKana).count > 0)
        #expect(Int16.min.formatted(.japaneseKana).count > 0)
        #expect(Int32.min.formatted(.japaneseKana).count > 0)
        #expect(Int64.min.formatted(.japaneseKana).count > 0)
        #expect(Int8.min.formatted(.japaneseKana).count > 0)
        #expect(UInt.min.formatted(.japaneseKana).count > 0)
        #expect(UInt16.min.formatted(.japaneseKana).count > 0)
        #expect(UInt32.min.formatted(.japaneseKana).count > 0)
        #expect(UInt64.min.formatted(.japaneseKana).count > 0)
        #expect(UInt8.min.formatted(.japaneseKana).count > 0)

        #expect(Int.max.formatted(.japaneseKana).count > 0)
        #expect(Int16.max.formatted(.japaneseKana).count > 0)
        #expect(Int32.max.formatted(.japaneseKana).count > 0)
        #expect(Int64.max.formatted(.japaneseKana).count > 0)
        #expect(Int8.max.formatted(.japaneseKana).count > 0)
        #expect(UInt.max.formatted(.japaneseKana).count > 0)
        #expect(UInt16.max.formatted(.japaneseKana).count > 0)
        #expect(UInt32.max.formatted(.japaneseKana).count > 0)
        #expect(UInt64.max.formatted(.japaneseKana).count > 0)
        #expect(UInt8.max.formatted(.japaneseKana).count > 0)
    }

    @Test func formatUnits() async throws {
        let formatStyle = JapaneseKanaNumberFormatStyle<Int>()

        #expect(formatStyle.format(1234_5678) == "せんにひゃくさんじゅうよんまんごせんろっぴゃくななじゅうはち")
        #expect(formatStyle.format(1000_1000_1000) == "せんおくせんまんせん")
        #expect(formatStyle.format(1_0000_0000_0000_0001) == "いっきょういち")
    }

    @Test func formatSoundChanges() async throws {
        let formatStyle = JapaneseKanaNumberFormatStyle<Int>()

        #expect(formatStyle.format(300) == "さんびゃく")
        #expect(formatStyle.format(600) == "ろっぴゃく")
        #expect(formatStyle.format(800) == "はっぴゃく")
        #expect(formatStyle.format(3000) == "さんぜん")
        #expect(formatStyle.format(8000) == "はっせん")
        #expect(formatStyle.format(1_0000_0000_0000) == "いっちょう")
        #expect(formatStyle.format(1_0000_0000_0000_0000) == "いっきょう")
    }
}

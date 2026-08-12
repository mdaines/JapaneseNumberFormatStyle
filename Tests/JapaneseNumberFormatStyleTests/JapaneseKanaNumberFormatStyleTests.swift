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
        #expect(formatStyle.format(31) == "さんじゅういち")
        #expect(formatStyle.format(54) == "ごじゅうよん")
        #expect(formatStyle.format(77) == "ななじゅうなな")
        #expect(formatStyle.format(20) == "にじゅう")
        #expect(formatStyle.format(4_3076) == "よんまんさんぜんななじゅうろく")
        #expect(formatStyle.format(7_0624_9222) == "ななおくろっぴゃくにじゅうよんまんきゅうせんにひゃくにじゅうに")
        #expect(formatStyle.format(500_0000_0002_0001) == "ごひゃくちょうにまんいち")
        #expect(formatStyle.format(567) == "ごひゃくろくじゅうなな")
        #expect(formatStyle.format(707) == "ななひゃくなな")
        #expect(formatStyle.format(1964) == "せんきゅうひゃくろくじゅうよん")
        #expect(formatStyle.format(2481) == "にせんよんひゃくはちじゅういち")
        #expect(formatStyle.format(1_0059) == "いちまんごじゅうきゅう")
        #expect(formatStyle.format(33_0479) == "さんじゅうさんまんよんひゃくななじゅうきゅう")
        #expect(formatStyle.format(1_9999_9099) == "いちおくきゅうせんきゅうひゃくきゅうじゅうきゅうまんきゅうせんきゅうじゅうきゅう")
        #expect(formatStyle.format(90) == "きゅうじゅう")
        #expect(formatStyle.format(900) == "きゅうひゃく")
        #expect(formatStyle.format(9000) == "きゅうせん")
    }

    @Test func formatZero() async throws {
        let formatStyle = JapaneseKanaNumberFormatStyle<Int>()

        #expect(formatStyle.format(0) == "ゼロ")
    }

    @Test func formatMinus() async throws {
        let formatStyle = JapaneseKanaNumberFormatStyle<Int>()

        #expect(formatStyle.format(-3) == "マイナスさん")
    }

    @Test func minMax() async throws {
        #expect(Int16.min.formatted(.japaneseKana) == "マイナスさんまんにせんななひゃくろくじゅうはち")
        #expect(Int32.min.formatted(.japaneseKana) == "マイナスにじゅういちおくよんせんななひゃくよんじゅうはちまんさんぜんろっぴゃくよんじゅうはち")
        #expect(Int64.min.formatted(.japaneseKana) == "マイナスきゅうひゃくにじゅうにきょうさんぜんさんびゃくななじゅうにちょうさんびゃくろくじゅうはちおくごせんよんひゃくななじゅうななまんごせんはっぴゃくはち")
        #expect(Int8.min.formatted(.japaneseKana) == "マイナスひゃくにじゅうはち")
        #expect(UInt16.min.formatted(.japaneseKana) == "ゼロ")
        #expect(UInt32.min.formatted(.japaneseKana) == "ゼロ")
        #expect(UInt64.min.formatted(.japaneseKana) == "ゼロ")
        #expect(UInt8.min.formatted(.japaneseKana) == "ゼロ")

        #expect(Int16.max.formatted(.japaneseKana) == "さんまんにせんななひゃくろくじゅうなな")
        #expect(Int32.max.formatted(.japaneseKana) == "にじゅういちおくよんせんななひゃくよんじゅうはちまんさんぜんろっぴゃくよんじゅうなな")
        #expect(Int64.max.formatted(.japaneseKana) == "きゅうひゃくにじゅうにきょうさんぜんさんびゃくななじゅうにちょうさんびゃくろくじゅうはちおくごせんよんひゃくななじゅうななまんごせんはっぴゃくなな")
        #expect(Int8.max.formatted(.japaneseKana) == "ひゃくにじゅうなな")
        #expect(UInt16.max.formatted(.japaneseKana) == "ろくまんごせんごひゃくさんじゅうご")
        #expect(UInt32.max.formatted(.japaneseKana) == "よんじゅうにおくきゅうせんよんひゃくきゅうじゅうろくまんななせんにひゃくきゅうじゅうご")
        #expect(UInt64.max.formatted(.japaneseKana) == "せんはっぴゃくよんじゅうよんきょうろくせんななひゃくよんじゅうよんちょうななひゃくさんじゅうななおくきゅうひゃくごじゅうごまんせんろっぴゃくじゅうご")
        #expect(UInt8.max.formatted(.japaneseKana) == "にひゃくごじゅうご")
    }

    @Test func formatUnits() async throws {
        let formatStyle = JapaneseKanaNumberFormatStyle<Int>()

        #expect(formatStyle.format(1) == "いち")
        #expect(formatStyle.format(2_0000) == "にまん")
        #expect(formatStyle.format(3_0000_0000) == "さんおく")
        #expect(formatStyle.format(4_0000_0000_0000) == "よんちょう")
        #expect(formatStyle.format(5_0000_0000_0000_0000) == "ごきょう")
        #expect(formatStyle.format(123_1234_1234_1234_1234) == "ひゃくにじゅうさんきょうせんにひゃくさんじゅうよんちょうせんにひゃくさんじゅうよんおくせんにひゃくさんじゅうよんまんせんにひゃくさんじゅうよん")
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

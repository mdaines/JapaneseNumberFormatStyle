enum JapaneseKanaNumberFormatStyleVocabulary {
    static let numerals = ["", "いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう"]
    static let minus = "マイナス"
    static let zero = "ゼロ"

    static func format0(_ n: Int) -> String? {
        switch n {
        case 0:
            nil
        case 1..<10:
            numerals[n]
        default:
            preconditionFailure()
        }
    }

    static func format1(_ n: Int) -> String? {
        switch n {
        case 0:
            nil
        case 1:
            "じゅう"
        case 2..<10:
            numerals[n] + "じゅう"
        default:
            preconditionFailure()
        }
    }

    static func format2(_ n: Int) -> String? {
        switch n {
        case 0:
            nil
        case 1:
            "ひゃく"
        case 3:
            "さんびゃく"
        case 6:
            "ろっぴゃく"
        case 8:
            "はっぴゃく"
        case 2, 4, 5, 7, 9:
            numerals[n] + "ひゃく"
        default:
            preconditionFailure()
        }
    }

    static func format3(_ n: Int) -> String? {
        switch n {
        case 0:
            nil
        case 1:
            "せん"
        case 3:
            "さんぜん"
        case 8:
            "はっせん"
        case 2, 4, 5, 6, 7, 9:
            numerals[n] + "せん"
        default:
            preconditionFailure()
        }
    }

    static func format4(_ n: Int) -> String? {
        if n == 0 {
            "まん"
        } else {
            numerals[n] + "まん"
        }
    }

    static func format8(_ n: Int) -> String? {
        if n == 0 {
            "おく"
        } else {
            numerals[n] + "おく"
        }
    }

    static func format12(_ n: Int) -> String? {
        if n == 0 {
            "ちょう"
        } else if n == 1 {
            "いっちょう"
        } else {
            numerals[n] + "ちょう"
        }
    }

    static func format16(_ n: Int) -> String? {
        if n == 0 {
            "きょう"
        } else if n == 1 {
            "いっきょう"
        } else {
            numerals[n] + "きょう"
        }
    }

    static func format20(_ n: Int) -> String? {
        numerals[n] + "がい"
    }

    static func format24(_ n: Int) -> String? {
        numerals[n] + "じょ"
    }

    static func format28(_ n: Int) -> String? {
        numerals[n] + "じょう"
    }

    static func format32(_ n: Int) -> String? {
        numerals[n] + "こう"
    }

    static func format36(_ n: Int) -> String? {
        numerals[n] + "かん"
    }
}

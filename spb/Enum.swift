
enum hoge {
    case hoge
}

enum Type: Int {
    
    case null = 0
    case bug = 1
    case dark = 2
    case dragon = 3
    case electric = 4
    
    case fairy = 5
    case fighting = 6
    case fire = 7
    case flying = 8
    case ghost = 9
    
    case grass = 10
    case ground = 11
    case ice = 12
    case normal = 13
    case poison = 14
    
    case psychic = 15
    case rock = 16
    case steel = 17
    case water = 18
}

enum Item: Int {
    case null
}


enum Ability: Int {
    
    case null
    
    case overgrow
    case blaze
    case torrent
    case roughskin
    case seidenki
    
    case synchronize
    case reckless
    case pixilate
    case steadfast
    case levitate
    
    case innerfocus
}

enum Gender: Int {
    case null
    case male
    case female
    case unknown
}


enum MoveCategory: String {
    case physical = "PHY"
    case special = "SPE"
    case status = "STA"
}


enum BadStatus:  String {
    case null = ""
    case poison = "POISON"
    case toxic = "TOXIC"
    case burned = "BURNED"
    case palalyze = "PALALYZE"
    case sleep = "SLEEP"
    case ice = "ICE"
    case faint = "FAINT"
}



public enum StatusChange: Equatable {
    
    case null
    case noroi(Int)
    case meromero
    case confuse(Int)
    case destinyBond(Int)
    case yawn(Int)
    case flinch
    
    // 以下、とくせいに起因するもの。
    // 「ステータス変化」ではないので本来おかしいのだが、
    // 処理の便宜を図る都合上、ここに記している。
    
    case roughskin
    case seidenki
    
    case synchronize
    
    
    public static func == (lhs: StatusChange, rhs: StatusChange) -> Bool {
        
        switch (lhs, rhs) {
            
        case (.null, .null), (.noroi, .noroi), (.meromero, .meromero), (.confuse, .confuse), (.destinyBond, .destinyBond), (.yawn, .yawn), (flinch, flinch):
            return true
        default:
            return false
        }
    }
    
    func reset() -> StatusChange {
        
        switch self {
            case .yawn(let count):
//                print("あくび 再セット")
                return .yawn(count)
            
            case .flinch:
//                print("ひるみ 再セット")
                return .flinch
            
            default:
//                print("虚無 こっちはありえない")
                return .yawn(0)
        }
    }
    
}



enum MoveProcess: Int {
    case null
    case giveDamage
    case healHP
    case givePalalyze
    case giveBurn
    case giveIce
    case giveSleep
    case givePoison
    case recoil
    case getBuffDebuff
    case makeDestinyBond
    case makeYawn
    case makeFlinch
}

// ターン終了時の状態異常の処理
enum EffectProcess: Int {
    case null
    case palarizeStun
    case poisonDamage
    case burnedDamage
}


//// わりこみ的に実行される処理
//enum InteruptProcess {
//    
//    // なし
//    case null
//    
//    // とくせい由来
//    case synchronize
//    
//    // ステータス変化由来
////    case destinyBond
////    case yawn
//    
//}


//// ターン終了時の、「場の状態」に応じた処理
//enum FieldEffectProcess: Int {
//    case stealthRockDamage
//}


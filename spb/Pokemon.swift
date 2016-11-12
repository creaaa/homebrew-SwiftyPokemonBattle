
import Foundation

public func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
    
    // これ後半、ただのいたずらやろ、　なおすぞ
    //return lhs.name == rhs.name && lhs.ATTACK == rhs.ATTACK
    
    return lhs.name == rhs.name
}


public class Pokemon: NSObject, NSCoding {
    
    // これらはあとから追加したので　バグある可能性も　高い
    var type2: Type
    var ability: Ability
    var gender: Gender
    
    var S_ATTACK: Int
    var S_DEFFENSE: Int
    

    var name: String
    var type1: Type
    
    var lv: Int
    
    let MAXHP: Int
    
    
    var tmpHP_toRestrictRecoilDamage = 0
    
    var HP: Int {
        
        didSet {
            if HP < 0 {
                HP = 0
                self.badStatus = .faint
            }
        }
        
        willSet {
            
            if newValue <= 0 {
                tmpHP_toRestrictRecoilDamage = HP
//                print("食い止めHPは \(tmpHP_toRestrictRecoilDamage)です")
            }
            
        }
        
        
        
    }
    var ATTACK: Int
    var DEFFENSE: Int
    var SPEED: Int
    
    var move1: Move
    var move2: Move
    var move3: Move
    var move4: Move
    
    var moveArray: [Move]
    
    var buffDebuff: BuffStruct = BuffStruct()
    
    var badStatus: BadStatus = .null
//        {
//        didSet {
//            if self.ability == .synchronize {
//                print("シンクロ 発動！")
//                manifestInteruptionProcessByAbility()
//            }
//        }
//    }
    
    // "◯◯状態"を格納する配列
    var statusChange: [StatusChange] = []
    
    // まひや混乱の行動判定をすりぬけて、行動できるか？ trueになったら行動できない
    var cantMove = false
    
    
    // すでに「ひんし」の状態か？ true = ひんし
    var isDead = false
    
    // 何ターンめに 場に出たか？(ねこだましのためだけに使われる)
    var appeardTurn = 0
    
    
    /////////////////
    // MARK: Function
    /////////////////
    
    
    // judgeに、[わざのプロセス]を送信する
    func doMove(moveNo: Int) -> [MoveProcess] {
        
        // こうしないと、みちづれで倒したとき、わざが発動してるように見えて変になる。
        // てかこの if > 0, 全部のprintに書かないとだめや。。。
        if HP > 0 {
            //print("\(name)の \(moveArray[moveNo-1].name)！")
            
            //myBVC.enqueue(reveivedStr: "\(name)の \(moveArray[moveNo-1].name)だよ！")
        }
        
//      print("俺のプロセスは \(moveArray[moveNo-1].process)だｚ！")
        
        return self.moveArray[moveNo-1].process
    }
    
    
    // judgeに、[状態異常のプロセス]を送信する (主に、お互いのターン終了時に処理される)
    func manifestMyselfEffect() -> EffectProcess {
        
        let myselfEffect: EffectProcess = judgeAndStackEffect(badStatus: badStatus)
        
        //print("スタックされた状態異常は、\(myselfEffect)です")
        
        return myselfEffect
    }
    
    // ↑ の 関数 の 実体
    func judgeAndStackEffect(badStatus: BadStatus) -> EffectProcess {
        
        if badStatus != .null {
            switch badStatus {
            case .poison, .toxic:
                //                  print("\(name)は どくの ダメージを うけている！")
                return .poisonDamage
            case .burned:
                //                  print("\(name)は やけどの ダメージを うけている！")
                return .burnedDamage
            case .palalyze:
                return .palarizeStun
            default:
                //                    print("なにもない")
                return .null
            }
        }
        return .null
    }
    
    
    // 割込処理 処理群 1: judgeに、【状態異常発生時】の[割込処理のプロセス]を送信する
    func manifestInteruptionProcessByBadStatus() -> StatusChange {
        
        let interuptionProcess: StatusChange = judgeAndStackInteruptionByBadStatus()
        
        return interuptionProcess
    }
    
    // ↑ の 関数 の 実体
    func judgeAndStackInteruptionByBadStatus() -> StatusChange {
     
        switch ability {
            case .synchronize:
//                print("シンクロ 発動！")
                return .synchronize
            default:
//                print("なにも せんよ...")
                return .null
        }
    }
    
    
    // 割込処理 処理群 2: judgeに、【ダメージ計算発生時】の[割込処理のプロセス]を送信する
    func manifestInteruptionProcessByDamageCalculation() -> [StatusChange] {
        
        let interuptionProcess: [StatusChange] = judgeAndStackInteruptionByDamageCaluculation()
        
        return interuptionProcess
    }
    
    // ↑ の 関数 の 実体
    func judgeAndStackInteruptionByDamageCaluculation() -> [StatusChange] {
        
        var damageCalculationProcessArray: [StatusChange] = []
        
        
        // 1. ステータス変化に起因するもの
        for eachStatusChange in statusChange {
        
            switch eachStatusChange {
                case .destinyBond:
                    //print("みちづれ 発動！")
                    damageCalculationProcessArray.append(eachStatusChange)
            
                default:
                    print("")
            }
        }
        
        // 2. とくせいに起因するもの
        
        switch ability {
            case .roughskin:
                //print("\(self.name)の さめはだ！")
                damageCalculationProcessArray.append(.roughskin)
            case .seidenki:
                //print("\(self.name)の せいでんき！")
                damageCalculationProcessArray.append(.seidenki)
            default:
                print("")
        }

        
        return damageCalculationProcessArray
    }

    
    // 処理群3: judgeに、【ターンエンド時の時】の[割込処理のプロセス]を送信する
    
    func manifestInteruptionProcessByTurnEnd() -> [StatusChange] {
        
        let interuptionProcess: [StatusChange] = judgeAndStackInteruptionByTurnEnd()
        
        return interuptionProcess
        
    }
    
    // ↑ の 関数 の 実体
    func judgeAndStackInteruptionByTurnEnd() -> [StatusChange] {
        
        var turnEndProcessArray: [StatusChange] = []
        
        for eachStatusChange in statusChange {
            
            switch eachStatusChange {
//              case .destinyBond:
//                  print("みちづれ 発動！")
//                  TurnEndProcessArray.append(.destinyBond)
                
                case .yawn:
                    
                    //print("あくび 発動！")
                    
//                    for derivedStatusChange in self.statusChange {
                    
//                        switch derivedStatusChange {
//                            case .yawn(_):
                                turnEndProcessArray.append(eachStatusChange)
                                
                            default:
                                print("")
                
//                        } // switch
//                    } // for
                }
        }
        
        return turnEndProcessArray
    }
    
    
    
    
    init(name: String, type1: Type, type2: Type, ability: Ability, gender: Gender, lv: Int, MAXHP: Int, HP: Int, ATTACK: Int, DEFFENSE: Int, S_ATTACK: Int, S_DEFFENSE: Int, SPEED: Int, move1: Move, move2: Move, move3: Move, move4: Move) {
        
        self.name = name
        self.type1 = type1
        self.type2 = type2
        
        self.ability = ability
        self.gender = gender
        
        self.lv = lv
        self.MAXHP = MAXHP
        self.HP = HP
        self.ATTACK = ATTACK
        self.DEFFENSE = DEFFENSE
        self.S_ATTACK = S_ATTACK
        self.S_DEFFENSE = S_DEFFENSE
        self.SPEED = SPEED
        
        self.move1 = move1
        self.move2 = move2
        self.move3 = move3
        self.move4 = move4
        
        moveArray = [move1, move2, move3, move4]

        
//        move1 = Move(name: "Flamethrower", type: .fire, power: 90, accuracy: 100, category: .special, process: [.givePalalyze], addEffectPer: 100)
//        move2 = Move(name: "Daimonji", type: .fire, power: 120, accuracy: 85, category: .special, process: [.giveDamage])
//        move3 = Move(name: "Kirisaku", type: .normal, power: 70, accuracy: 100, category: .psysical, process: [.giveDamage])
//        move4 = Move(name: "Tubasade utsu", type: .normal, power: 55, accuracy: 100, category: .psysical,  process: [.giveDamage, .null])
        
        
//        move1 = Move(name: "Flamethrower", type: .fire, power: 90, accuracy: 80, category: .special, process: [.giveDamage, .givePalalyze], addEffectPer: 30, buffLevel: [0,0,0,0,0])
//        move2 = Move(name: "Flamethrower", type: .fire, power: 90, accuracy: 100, category: .special, process: [.giveDamage, .healHP], addEffectPer: 100, buffLevel: [0,0,0,0,0])
//        move3 = Move(name: "Flamethrower", type: .fire, power: 90, accuracy: 100, category: .special, process: [.giveDamage, .healHP], addEffectPer: 100, buffLevel: [0,0,0,0,0])
//        move4 = Move(name: "Flamethrower", type: .fire, power: 90, accuracy: 100, category: .special, process: [.giveDamage, .healHP], addEffectPer: 100, buffLevel: [0,0,0,0,0])
        
        // なぜかレポジトリからわざをスロットインすることができないので、これは一旦あきらめよう。
        //        move1 = repository.Moves[0]
        //        move2 = repository.Moves[0]
        //        move3 = repository.Moves[0]
        //        move4 = repository.Moves[0]
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        
        self.name = aDecoder.decodeObject(forKey: "pokeName") as! String
        
        let type1Raw = aDecoder.decodeInteger(forKey: "pokeType1")
        self.type1 = Type(rawValue: type1Raw)!
        
        let type2Raw = aDecoder.decodeInteger(forKey: "pokeType2")
        self.type2 = Type(rawValue: type2Raw)!
        
        let abilityRaw = aDecoder.decodeInteger(forKey: "pokeAbility")
        self.ability = Ability(rawValue: abilityRaw)!
        
        let genderRaw = aDecoder.decodeInteger(forKey: "pokeGender")
        self.gender = Gender(rawValue: genderRaw)!
        
        
        
        
        self.lv = aDecoder.decodeInteger(forKey: "pokeLv")
        self.MAXHP = aDecoder.decodeInteger(forKey: "pokeMAXHP")
        self.HP = aDecoder.decodeInteger(forKey: "pokeHP")
        self.ATTACK = aDecoder.decodeInteger(forKey: "pokeATTACK")
        self.DEFFENSE = aDecoder.decodeInteger(forKey: "pokeDEFFENSE")
        self.S_ATTACK = aDecoder.decodeInteger(forKey: "pokeS_ATTACK")
        self.S_DEFFENSE = aDecoder.decodeInteger(forKey: "pokeS_DEFFENSE")
        self.SPEED = aDecoder.decodeInteger(forKey: "pokeSPEED")
        
        
        
        self.move1 = aDecoder.decodeObject(forKey: "pokeMove1") as! Move
        self.move2 = aDecoder.decodeObject(forKey: "pokeMove2") as! Move
        self.move3 = aDecoder.decodeObject(forKey: "pokeMove3") as! Move
        self.move4 = aDecoder.decodeObject(forKey: "pokeMove4") as! Move
        
        moveArray = [move1, move2, move3, move4]
    }


    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.name, forKey: "pokeName")
        
        aCoder.encode(self.type1.rawValue, forKey: "pokeType1")
        
        
        aCoder.encode(self.type2.rawValue, forKey: "pokeType2")
        aCoder.encode(self.ability.rawValue, forKey: "pokeAbility")
        aCoder.encode(self.gender.rawValue, forKey: "pokeGender")
        

        
        aCoder.encode(self.lv, forKey: "pokeLv")
        aCoder.encode(self.MAXHP, forKey: "pokeMAXHP")
        aCoder.encode(self.HP, forKey: "pokeHP")
        aCoder.encode(self.ATTACK, forKey: "pokeATTACK")
        aCoder.encode(self.DEFFENSE, forKey: "pokeDEFFENSE")
        aCoder.encode(self.S_ATTACK, forKey: "pokeS_ATTACK")
        aCoder.encode(self.S_DEFFENSE, forKey: "pokeS_DEFFENSE")
        aCoder.encode(self.SPEED, forKey: "pokeSPEED")
        
        aCoder.encode(self.move1, forKey: "pokeMove1")
        aCoder.encode(self.move2, forKey: "pokeMove2")
        aCoder.encode(self.move3, forKey: "pokeMove3")
        aCoder.encode(self.move4, forKey: "pokeMove4")
        
//        moveArray = [move1, move2, move3, move4]
    }
}






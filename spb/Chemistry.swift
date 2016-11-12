
import Foundation

struct Chemistry {
    
    static let chemistry = [
        
        // 以下、タイプは「こうげきする技のタイプ」のこと
        
        // 0.なし
        [1.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0],
        
        // 1. むし
        [1.0, 1.0, 2.0, 1.0, 1.0,
         0.5, 0.5, 0.5, 0.5, 0.5,
        2.0, 1.0, 1.0, 1.0, 0.5,
        2.0, 1.0, 0.5, 1.0],
        
        // 2. あく
        [1.0, 1.0, 0.5, 1.0, 1.0,
         0.5, 0.5, 1.0, 1.0, 2.0,
         1.0, 1.0, 1.0, 1.0, 1.0,
         2.0, 1.0, 1.0, 1.0],
        
        
        // 3.ドラゴン
        [1.0, 1.0, 1.0, 2.0, 1.0,
         0.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 0.5, 1.0],
        
        // 4.でんき
        [1.0, 1.0, 1.0, 0.5, 0.5,
         1.0, 1.0, 1.0, 2.0, 1.0,
         0.5, 0.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 2.0],
        
        
        // 5. フェアリー
        [1.0, 1.0, 2.0, 2.0, 1.0,
         1.0, 2.0, 0.5, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0, 0.5,
         1.0, 1.0, 0.5, 1.0],
        
        // 6. かくとう
        [1.0, 0.5, 2.0, 1.0, 1.0,
         0.5, 1.0, 1.0, 0.5, 0.0,
         1.0, 1.0, 2.0, 2.0, 0.5,
         0.5, 2.0, 2.0, 1.0],
        
        // 7.ほのお
        [1.0, 2.0, 1.0, 0.5, 1.0,
         1.0, 1.0, 0.5, 1.0, 1.0,
         2.0, 1.0, 2.0, 1.0, 1.0,
         1.0, 0.5, 2.0, 0.5],
        
        // 8. ひこう
        [1.0, 2.0, 1.0, 1.0, 0.5,
         1.0, 2.0, 1.0, 1.0, 1.0,
         2.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 0.5, 0.5, 1.0],
        
        // 9. ゴースト
        [1.0, 1.0, 0.5, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0, 2.0,
         1.0, 1.0, 1.0, 0.0, 1.0,
         2.0, 1.0, 1.0, 1.0],
        
        
        // 10.くさ
        [1.0, 0.5, 1.0, 0.5, 0.5,
         1.0, 1.0, 0.5, 0.5, 1.0,
         0.5, 2.0, 1.0, 1.0, 0.5,
         1.0, 2.0, 0.5, 2.0],
        
        // 11.じめん
        [1.0, 0.5, 1.0, 1.0, 2.0,
         1.0, 1.0, 2.0, 0.0, 1.0,
         0.5, 1.0, 1.0, 1.0, 2.0,
         1.0, 2.0, 2.0, 1.0],
        
        // 12. こおり
        [1.0, 1.0, 1.0, 2.0, 1.0,
         1.0, 1.0, 0.5, 2.0, 1.0,
         2.0, 2.0, 0.5, 1.0, 1.0,
         1.0, 1.0, 0.5, 0.5],
        
        // 13.ノーマル
        [1.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0, 0.0,
         1.0, 1.0, 1.0, 1.0, 1.0,
         1.0, 0.5, 0.5, 1.0],
        
        // 14.どく
        [1.0, 1.0, 1.0, 1.0, 1.0,
         2.0, 1.0, 1.0, 1.0, 0.5,
         2.0, 0.5, 1.0, 1.0, 0.5,
         1.0, 0.5, 0.0, 1.0],
        
        
        // 15. エスパー
        [1.0, 1.0, 0.0, 1.0, 1.0,
         1.0, 2.0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 1.0, 2.0,
         0.5, 1.0, 0.5, 1.0],
        
        // 16. いわ
        [1.0, 2.0, 1.0, 1.0, 1.0,
         1.0, 0.5, 2.0, 2.0, 1.0,
         1.0, 0.5, 2.0, 1.0, 1.0,
         1.0, 1.0, 0.5, 1.0],
        
        // 17. はがね
        [1.0, 1.0, 1.0, 1.0, 0.5,
         2.0, 1.0, 0.5, 1.0, 1.0,
         1.0, 1.0, 2.0, 1.0, 1.0,
         1.0, 2.0, 0.5, 0.5],
        
        // 18. みず
        [1.0, 1.0, 1.0, 0.5, 1.0,
         1.0, 1.0, 2.0, 1.0, 1.0,
         0.5, 2.0, 1.0, 1.0, 1.0,
         1.0, 2.0, 1.0, 0.5]
    ]
}

struct CalculateDamage {

    static func calcurateDamage(whoIsTurn: Bool, moveNo: Int, attacker: Pokemon, deffenser: Pokemon) -> Int {
        
        func judgeCritical() -> Bool {
            
            let criRand = Int(arc4random_uniform(10000))
            
            // 625
            if criRand < 625 {
                
                // エンキュー
                if lang == true {
                    myBVC.enqueue(reveivedStr: "きゅうしょに あたった!")
                } else {
                    myBVC.enqueue(reveivedStr: "It's Critical Hit!")
                }
                
                // ここで、即、typewriteしても大丈夫！?インデックス強制エラーにならないか？
                // 11/11 20:34 急遽 ここで即出さず、ダメージ・アニメの最後のところで　まとめてtypewriteすることにした
                // やばかったらコメントインして
//                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
                return true
            }
            
            return false
        }
        
        
        // 急所判定
        let isCritical = judgeCritical()
        
        
        // 今、自分のターンなら 0、 相手のターンなら 1
//        let turnNo = whoIsTurn ? 0 : 1
        
//        print("いま \(turnNo)の 攻撃処理！！")
//        print("\(attacker.moveArray[moveNo-1].name)の いりょくは　\(attacker.moveArray[moveNo-1].power)！")
//        print("")
        
//        print("いま 攻撃者 \(attacker.name)の こうげきは \(attacker.ATTACK), とくこうは \(attacker.S_ATTACK)！！")
//        print("いま 防御者 \(deffenser.name)の ぼうぎょは \(deffenser.DEFFENSE), とくぼうは \(deffenser.S_DEFFENSE)！！")

        
        // {（攻撃側レベル × 2 ÷ 5 ＋ 2）× 技の威力 × 攻撃側の能力値 ÷ 防御側の能力値 ÷ 50 ＋ 2} ×（85～100）÷ 100
        
        // (括弧)内の計算
        let dp1: Int = attacker.lv * 2 / 5 + 2
        
        // STEP1: 攻撃側の能力値の計算
        var attackerStat: Int = 0
        var deffenserStat: Int = 0
        
        // 「ぶつり」技か「とくしゅ」技かで処理が分岐
        switch attacker.moveArray[moveNo-1].category {
            
            case .physical:
                
                //attackerStat = attacker.ATTACK
               //attackerStat = Int(Double(attackerStat) * attacker.buffDebuff.mag_StatsArray[0])
                //                deffenserStat = deffenser.DEFFENSE

//                print("現在の 攻撃側の バフレベル: \(attacker.buffDebuff.statsLVArray[0])")
//                print("現在の 攻撃側の バフレベル倍率: \(attacker.buffDebuff.mag_StatsArray[0])")
//                print("現在の 防御側の バフレベル: \(deffenser.buffDebuff.statsLVArray[1])")
//                print("現在の 防御側の バフレベル倍率: \(deffenser.buffDebuff.mag_StatsArray[1])")
//                
//                print("いま 攻撃者 \(attacker.name)の こうげきは \(attacker.ATTACK), 防御者 \(deffenser.name)の ぼうぎょは \(deffenser.DEFFENSE)！！")
                
                // 急所時は、こうげきデバフ・ぼうぎょバフは無視される
                if isCritical {
                    
                    let buffDebuffCond: (Int, Int) = (attacker.buffDebuff.atkLv, deffenser.buffDebuff.defLv)
                    
                    switch buffDebuffCond {
                        
                        case (-6 ... 0, 1...6):
                            attackerStat = attacker.ATTACK
                            deffenserStat = deffenser.DEFFENSE
                        
                        case (-6 ... 0, -6 ... 0):
                            attackerStat = attacker.ATTACK
                            deffenserStat = Int(Double(deffenser.DEFFENSE) * deffenser.buffDebuff.mag_StatsArray[1])

                        case (1...6, 1...6):
                            attackerStat = Int(Double(attacker.ATTACK) * attacker.buffDebuff.mag_StatsArray[0])
                            deffenserStat = deffenser.DEFFENSE
                        
                        case (1...6, -6 ... 0):
                            attackerStat = Int(Double(attacker.ATTACK) * attacker.buffDebuff.mag_StatsArray[0])
                            deffenserStat = Int(Double(deffenser.DEFFENSE) * deffenser.buffDebuff.mag_StatsArray[1])

                        // ここ　ありえないでしょ ↑で全部カバーできとるやろ
                        default:
                            print("")
                        
                    }
                    

                    
                } else {  // 急所ではないとき(通常時)
                
                    attackerStat = Int(Double(attacker.ATTACK) * attacker.buffDebuff.mag_StatsArray[0])
                    deffenserStat = Int(Double(deffenser.DEFFENSE) * deffenser.buffDebuff.mag_StatsArray[1])
                
                }

//                print("ぶつりわざ！")
            
            case .special:
                
//                print("現在の 特攻側の バフレベル: \(attacker.buffDebuff.statsLVArray[2])")
//                print("現在の 特攻側の バフレベル倍率: \(attacker.buffDebuff.mag_StatsArray[2])")
//                print("現在の 特防側の バフレベル: \(deffenser.buffDebuff.statsLVArray[3])")
//                print("現在の 特防側の バフレベル倍率: \(deffenser.buffDebuff.mag_StatsArray[3])")
//                
//                print("いま 攻撃者 \(attacker.name)の とくこうは \(attacker.S_ATTACK), 防御者 \(deffenser.name)の とくぼうは \(deffenser.S_DEFFENSE)！！")
                

            
                // 急所時は、とくこうデバフ・とくぼうバフは無視される
                if isCritical {
                    
                    let buffDebuffCond: (Int, Int) = (attacker.buffDebuff.s_atkLv, deffenser.buffDebuff.s_defLv)
                    
                    switch buffDebuffCond {
                        
                        case (-6 ... 0, 1...6):
                            attackerStat = attacker.S_ATTACK
                            deffenserStat = deffenser.S_DEFFENSE
                            
                        case (-6 ... 0, -6 ... 0):
                            attackerStat = attacker.S_ATTACK
                            deffenserStat = Int(Double(deffenser.S_DEFFENSE) * deffenser.buffDebuff.mag_StatsArray[3])
                            
                        case (1...6, 1...6):
                            attackerStat = Int(Double(attacker.S_ATTACK) * attacker.buffDebuff.mag_StatsArray[2])
                            deffenserStat = deffenser.S_DEFFENSE
                            
                        case (1...6, -6 ... 0):
                            attackerStat = Int(Double(attacker.S_ATTACK) * attacker.buffDebuff.mag_StatsArray[2])
                            deffenserStat = Int(Double(deffenser.S_DEFFENSE) * deffenser.buffDebuff.mag_StatsArray[3])
                            
                        // ここ　ありえないでしょ ↑で全部カバーできとるやろ
                        default:
                            print("")
                        
                    }
                    
                    
                    
                } else {  // 急所ではないとき(通常時)
                    
                    attackerStat = Int(Double(attacker.S_ATTACK) * attacker.buffDebuff.mag_StatsArray[2])
                    deffenserStat = Int(Double(deffenser.S_DEFFENSE) * deffenser.buffDebuff.mag_StatsArray[3])
                    
            }
            
                
//                print("とくしゅわざ！")
            
            default: // ステータスわざ
                attackerStat = 0
                deffenserStat = 0
//                print("これでてるの おかしいで")
        }
        
        
        var movePower = attacker.moveArray[moveNo-1].power
        
        
        
        ////////////////////////
        /// 以下、とくせいの処理 ///
        ////////////////////////
        
        
        // たたりめ
        if attacker.moveArray[moveNo-1].name == "Hex" {
            if deffenser.badStatus != .null {
                movePower *= 2
//                print("弱り目に祟り目！いりょくが2倍！")
            }
        }
        
        // すてみ
        if attacker.ability == .reckless && attacker.moveArray[moveNo-1].name == "High Jump Kick" {
            let tmpMovePower = Double(movePower)
            movePower = Int(tmpMovePower * 1.2)
//            print("すてみ発動！いりょくが1.2倍！")
        }
        
        // フェアリースキン
        if attacker.ability == .pixilate && attacker.moveArray[moveNo-1].type == .normal {
            let tmpMovePower = Double(movePower)
            movePower = Int(tmpMovePower * 1.3)
//            debugPrint("フェアリースキン発動！いりょくが1.3倍！")
        }
        
        // しんりょく・もうか・げきりゅう
        if attacker.HP <= attacker.MAXHP / 3 {
            
            let attackerAbility = attacker.ability
            
            switch attackerAbility {
                case .overgrow:
                    if attacker.moveArray[moveNo-1].type == .grass {
                        let tmpMovePower = Double(movePower)
                        movePower = Int(tmpMovePower * 1.5)
    //                    print("しんりょく はつどう!")
                    }
                case .blaze:
                    if attacker.moveArray[moveNo-1].type == .fire {
                        let tmpMovePower = Double(movePower)
                        movePower = Int(tmpMovePower * 1.5)
    //                    print("もうか はつどう!")
                    }
                case .torrent:
                    if attacker.moveArray[moveNo-1].type == .water {
                        let tmpMovePower = Double(movePower)
                        movePower = Int(tmpMovePower * 1.5)
    //                    print("げきりゅう はつどう!")
                    }
                default:
                    print("")
            }
        }
        
        
        
        // STEP2: 乱数が入る直前までの演算
        let dp2: Int = dp1 * movePower * attackerStat / deffenserStat / 50 + 2
        
        // 乱数(85〜100までの16段階を取りうる)
        let rand = Int(arc4random_uniform(16)) + 85
        
        // STEP3: 元となるダメージ演算の完成
        var dp3 = dp2 * rand / 100
        
//        print("元となるダメージ: \(dp3)")
        
        // STEP3-1: タイプ一致
        if attacker.type1 == attacker.moveArray[moveNo-1].type || attacker.type2 == attacker.moveArray[moveNo-1].type {
            dp3 = Int(Double(dp3) * 1.5)
//            print("タイプ一致！1.5倍！")
        }
        
        
        
        // STEP3-2: 弱点判定(なお、これは"攻撃者"から見た相性)
        let chemistry1: Double
        let chemistry2: Double
        
        
        
        // ここに フェアリースキンの「フェアリー化」処理を書くことで、
        // ↑の 1.5倍化を防げる。ナイス
        
        if attacker.ability == .pixilate && attacker.moveArray[moveNo-1].type == .normal {
            
            // [5] とは、もちろん「フェアリータイプ」のこと
            chemistry1 = Chemistry.chemistry[5][deffenser.type1.rawValue]
            chemistry2 = Chemistry.chemistry[5][deffenser.type2.rawValue]
            
        } else {
            
            chemistry1 = Chemistry.chemistry[attacker.moveArray[moveNo-1].type.rawValue][deffenser.type1.rawValue]
            chemistry2 = Chemistry.chemistry[attacker.moveArray[moveNo-1].type.rawValue][deffenser.type2.rawValue]
            
        }
        
//        print("相性1は \(Chemistry.chemistry[attacker.moveArray[moveNo-1].type.rawValue]) \(deffenser.type1.rawValue) です")
//        
//        print("相性2は \(Chemistry.chemistry[attacker.moveArray[moveNo-1].type.rawValue]) \(deffenser.type2.rawValue) です")
//        
//        
//        print("相性係数は \(chemistry1) \(chemistry2) です")
        
        
        // 11/11 20:34 「こうかは ◯◯だ」を、急遽　ここで即出さず、ダメージ・アニメの最後のところで　まとめてtypewriteすることにした
        // やばかったらコメントインして
        
        switch chemistry1 * chemistry2 {
            
            case 4.0:
                
//                print("こうかは 超ばつぐんだ！")
            
                // エンキュー
                if lang == true {
                    myBVC.enqueue(reveivedStr: "こうかは 超ばつぐんだ！")
                } else {
                    myBVC.enqueue(reveivedStr: "It's HYPER effective!!")
                }
                
//                myBVC.outputBattleMessageLikeTypeWriter()
            
                judge.storeValueToTmpVar()
            
            case 2.0:
                
//                print("こうかは ばつぐんだ！")
            
                // エンキュー
                if lang == true {
                    myBVC.enqueue(reveivedStr: "こうかは ばつぐんだ！")
                } else {
                    myBVC.enqueue(reveivedStr: "It's super effective!")
                }
                
//                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
            
            case 1.0:
            
                print("")
//                print("等倍")
            
            case 0.5:
                
//                print("こうかは いまひとつの ようだ...")
            
                // エンキュー
                if lang == true {
                    myBVC.enqueue(reveivedStr: "こうかは いまひとつの ようだ...")
                } else {
                    myBVC.enqueue(reveivedStr: "It's not very effective...")
                }
                
//                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
            
            case 0.25:
                print("こうかは 超いまひとつの ようだ...")
            
                // エンキュー
                if lang == true {
                    myBVC.enqueue(reveivedStr: "こうかは 超いまひとつの ようだ...")
                } else {
                    myBVC.enqueue(reveivedStr: "It's rarely effective...")
                }
                
//                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
            
            default:
                print("irregular!")
            
                // エンキュー
//                myBVC.enqueue(reveivedStr: "異常事態発生")
//            
//                myBVC.outputBattleMessageLikeTypeWriter()
//                
//                judge.storeValueToTmpVar()
        }
        
        dp3 = Int(Double(dp3) * chemistry1 * chemistry2)
        
        
        // STEP4: 急所の判定
        if isCritical {
            
            dp3 = Int(Double(dp3) * 1.5)
//            print("きゅうしょに あたった！")
            
            // エンキュー
//            myBVC.enqueue(reveivedStr: "きゅうしょに あたった！")
//            
//            // ここで、即、typewriteしても大丈夫！インデックス強制エラーにならないか？
//            myBVC.outputBattleMessageLikeTypeWriter()
//            
//            judge.storeValueToTmpVar()
        }
        
        
        
        
        // サブ判定: やけどによるぶつり技のダメージ 1/2倍　判定
        
        if attacker.badStatus == .burned && attacker.moveArray[moveNo-1].category == .physical {
            
            dp3 = Int(Double(dp3) / 2)
            
        }

        return dp3
          
    }
}
    

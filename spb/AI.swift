
import Foundation

enum Condition {
    
    case null
    case rest15perHP // こちらの残りHPが15%以下
    case canHitWeakPoint // 最低1個以上の敵の攻撃わざが、こちらのポケモンの弱点を突くことができる
    case isNoGoodAffinity //
}

enum Behavior {
    
    case null
    case quickAttackForfatalBlow // とどめの先制技
    case aggressiveWeakPointAttack // 無鉄砲な弱点攻撃
    case pokemonChangeToGoodAffinityType // 相性有利なポケモンにチェンジ
}

enum DecidedActionStyle {
    
    case null
    case quickAttackForfatalBlow
    case aggressiveWeakPointAttack
    case pokemonChangeToGoodAffinityType
    
    case normalAttackMove
    
    
}


extension Move {
    
    // 現在の「ふるまい」に応じて、条件のチェック
    func returnSearchConditionByBehavior(behavior: Behavior) -> Bool {
        
        switch behavior {
            
            case .quickAttackForfatalBlow:
                
                return self.isAttackMove() && self.isHighPriority() && self.isNotNoEffect(myPokemon: judge.battleField.myBattlePokemon)
            
            case .aggressiveWeakPointAttack:
            
                return self.isAttackMove() && self.canHitWeakPoint(myPokemon: judge.battleField.myBattlePokemon)
            
            case .pokemonChangeToGoodAffinityType:
            
                break

            case .null:
                break
        }
        
        return false
    }
    
    
    // 「決定された行動様式」に応じて、条件のチェック
    func returnSearchConditionByDecidedActionStyle(das: DecidedActionStyle) -> Bool {
        
        switch das {
            
            case .normalAttackMove:
            
                return isAttackMove() && isNotNoEffect(myPokemon: judge.battleField.myBattlePokemon)
            
            default:
            
                break
        
        }
        
        return false
    }
    
    
    
    
    
    //////////////
    // 検索条件群 //
    //////////////
    
    
    // 相手のふゆう...など、例外的な事象をすりぬけ、相手にヒットさせることができるか
    // (要するに、相手が ふゆう を持っているとき、じめんタイプの攻撃わざを撃ちたくない)
    
//    private func isEffectivePassingThroughSomeReason() -> Bool {
//    
//        
//        // 「はい！自分(このわざ)は "じしん"ではないし、当然地面タイプでもありません」
//        if self.name != "じしん" {
//        
//            return true
//        
//        } else {
//            
//            return false
//            
//        }
//        
//    }
    
    
    // 汎用
    private func isAttackMove() -> Bool {
        
        if self.category != .status {
            return true
        } else {
            return false
        }
    }
    
    
    // A.
    private func isHighPriority() -> Bool {
        
        if self.priority > 0 {
            return true
        } else {
            return false
        }
        
    }
    
    private func isNotNoEffect(myPokemon: Pokemon) -> Bool {
        
        if Chemistry.chemistry[self.type.rawValue][myPokemon.type1.rawValue] != 0.0 && Chemistry.chemistry[self.type.rawValue][myPokemon.type2.rawValue] != 0.0 {
            
            return true
        } else {
            return false
        }
    }
    
    
    // B.
    private func canHitWeakPoint(myPokemon: Pokemon) -> Bool {
        
        if Chemistry.chemistry[self.type.rawValue][myPokemon.type1.rawValue] * Chemistry.chemistry[self.type.rawValue][myPokemon.type2.rawValue] >= 2.0 {
            return true
        } else {
            return false
        }
    }
  
}


extension AI {
    
    // 敵(AI)自身が、ポケモンチェンジ可能かどうかを解析する関数
    func isChangable() -> (Bool, Int) {
        
        var KOcount = 0
        
        for x in judge.battleField.foeParty {
            
            if x.HP <= 0 {
                KOcount += 1
            }
        }
        
        if KOcount >= 2 {
            return (changable: false, count: KOcount)
        } else {
            return (changable: true, count: KOcount)
        }
    }
    
}


class AI {
    
    
    init(myPokemon my: Pokemon, foePokemon foe: Pokemon, foePokemonAry: [Pokemon]) {
    
        self.myPokemon = my
        
        self.foePokemon = foe
        self.foeMoveAry = [foe.moveArray[0], foe.moveArray[1], foe.moveArray[2], foe.moveArray[3]]
        
        self.foePokemonAry = foePokemonAry
        
    }
    
    
    let myPokemon: Pokemon
    let foePokemon: Pokemon
    
    let foePokemonAry: [Pokemon]
    
    
    
    let foeMoveAry: [Move]
    
    
    
    // 現在の"条件"が格納される
    var condition: Condition = .null
    
    // 現在の"ふるまい"が格納される
    var behavior: Behavior = .null
    
    // 決定された"行動様式"が格納される
    var decidedActionStyle: DecidedActionStyle = .null
    
    // 敵が使いたいわざを格納
    var derivedMoveAry: [Move] = []
    
    // 敵が使いたいわざのタイプを格納
    var kouhoType: [Type] = []
    
    // 敵が交代したいポケモンのタイプを格納
    var kouhoChangePokemonType: [Type] = []
    

    //////////////////////////
    /// 決定された敵の行動No. ///
    /////////////////////////

    var decidedFoeActionNo = 1
    
    
    // 外部から見れば、この関数だけが実行される
    func generateAction() -> Int {
        
        condition = analyzeCondition()
        behavior = decideBehaviorByCondition()
        decideMoveByBehavior()
        
        return decidedFoeActionNo
        
    }
    
    
    
    // STEP1: 現在の状況を解析し、Condition Enum を返す
    func analyzeCondition() -> Condition {
        
        // A. こちらのHPが15%以下 + 優先技を持っており、そのわざは「効果なし」ではない
        let rest15perHP = Double(myPokemon.MAXHP) * 0.15
        let nowMyHP = Double(myPokemon.HP)
        
        
        // B. 持っているわざで、こちらのポケモンの弱点を突くことができる
        func canHitWeakPoint() -> Bool {
            
            for eachMove in foeMoveAry {
                
                let isAttackMove = eachMove.category != .status
                
                let canHitWeakPointOfMyPokemonType1 = Chemistry.chemistry[eachMove.type.rawValue][myPokemon.type1.rawValue]
                
                let canHitWeakPointOfMyPokemonType2 = Chemistry.chemistry[eachMove.type.rawValue][myPokemon.type2.rawValue]
                
                if isAttackMove && canHitWeakPointOfMyPokemonType1 * canHitWeakPointOfMyPokemonType2 >= 2.0 {

                    return true
                }
            }
            
            return false
        }
        
        
        // C. 対面相性が不利(こちらのポケモンのタイプのわざが敵ポケモンにとって効果ばつぐん)
        
        // ちょっと　変更しますね...
//        let isNoGoodAffinity1 = Chemistry.chemistry[myPokemon.type1.rawValue][foePokemon.type1.rawValue] == 2.0 || Chemistry.chemistry[myPokemon.type1.rawValue][foePokemon.type2.rawValue] == 2.0
//        let isNoGoodAffinity2 = Chemistry.chemistry[myPokemon.type2.rawValue][foePokemon.type1.rawValue] == 2.0 || Chemistry.chemistry[myPokemon.type2.rawValue][foePokemon.type2.rawValue] == 2.0

        
        // そう こんなふうに...
        
        // 最大 4 になりうる。
        let affinity1 = Chemistry.chemistry[myPokemon.type1.rawValue][foePokemon.type1.rawValue] * Chemistry.chemistry[myPokemon.type1.rawValue][foePokemon.type2.rawValue]
        // 最大 4 になりうる。
        let affinity2 = Chemistry.chemistry[myPokemon.type2.rawValue][foePokemon.type1.rawValue] * Chemistry.chemistry[myPokemon.type2.rawValue][foePokemon.type2.rawValue]

        
        
        

        // A.
        if rest15perHP >= nowMyHP {

            return .rest15perHP
        }
        
        // B.
        else if canHitWeakPoint() {
            
            return .canHitWeakPoint
        
        // C.
        } else if affinity1 + affinity2 > 2.0 {
            
            return .isNoGoodAffinity
        }
        
        // Default.
        
        return .null
    }
        

    // STEP2: 解析した状況に応じて、"ふるまい"名を決定
    func decideBehaviorByCondition() -> Behavior {
        
        switch condition {
            
            case .rest15perHP:
                return .quickAttackForfatalBlow
            case .canHitWeakPoint:
                return .aggressiveWeakPointAttack
            case .isNoGoodAffinity:
                return .pokemonChangeToGoodAffinityType
            case .null:
                return .null
        }
        
    }
        

    // STEP3: 決定された"ふるまい"に応じて、実際にどのわざを出すかを決定
    func decideMoveByBehavior() {
        
        switch behavior {
            
            case .quickAttackForfatalBlow:
                
                decidedActionStyle = .quickAttackForfatalBlow
                quickAttackForfatalBlow()
            
            case .aggressiveWeakPointAttack:
                
                decidedActionStyle = .aggressiveWeakPointAttack
                aggressiveWeakPointAttack()

            case .pokemonChangeToGoodAffinityType:
                
                decidedActionStyle = .pokemonChangeToGoodAffinityType
                pokemonChangeToGoodAffinityType()
            
            case .null:
//                null()
            
                // decidedActionStyle = .normalAttackMove // これ、こんなふうに呼び出す直前に書くと書き忘れるので、
                // ↓の関数の中で宣言しろや。
                normalAttackMove()
        }
        
    }

    
    // MARK: ユーティリティ関数
    
    
    // 該当したわざが、自分が持つ何個目のわざにあたるかを突き合わせる処理
    func identifyMoveNo(move: Move) -> Int {
        
        // 0 = 1ばんめのわざ, の意
        var idx: Int = 0
        
        for eachMove in foeMoveAry {
            
            if eachMove.name == move.name {
                
                idx = foeMoveAry.index(of: move)!
            }
        }
        
        return idx
    }

    // MARK: 条件に該当するわざを検索する関数
    func searchMoveByBehavior() {
        
        var hitAry: [Move] = []
        
        for eachMove in foeMoveAry {
            
            if eachMove.returnSearchConditionByBehavior(behavior: behavior) {
                hitAry.append(eachMove)
            }
        }
        // ここまではOK、でんこうせっかは　hitAry に ちゃんと入った。
        
        
        
        
        
        derivedMoveAry = hitAry
        
        for each in derivedMoveAry {
//            print("抽出ささされたわざは \(each.name) だぞ")
        }
        
        // ↑の関数により、わざ候補が derivedMoveAryに格納されたはずなので、
        // 相手のとくせいが ふゆう なら、このタイミングでわざ候補の中から"じしん"をremoveすればよい
        
        if myPokemon.ability == .levitate {
            
            derivedMoveAry = derivedMoveAry.filter({$0.name != "Earthquack"})
//            print("除去後の相手の抽出されたこうげきリストは　\(derivedMoveAry) だぞ！")
        }
        
        
        // 同じように、ねこだましも1ターンめにしか出さないようにしないと くそ弱い
        
        if turn != foePokemon.appeardTurn + 1 {
            
            derivedMoveAry = derivedMoveAry.filter({$0.name != "Fake Out"})
//            print("これは 猫騙し判定 先制攻撃攻撃様式だ 除去後の相手の抽出されたこうげきリストは　\(derivedMoveAry) だぞ！")
            
            for each in derivedMoveAry {
//                print("抽出pocoわざは \(each.name) だぞ")
            }
        }
        
        
    }
    
    
    
    func searchMoveByDecidedActionStyle() {
        
        var hitAry: [Move] = []
        
        for eachMove in foeMoveAry {
            
            if eachMove.returnSearchConditionByDecidedActionStyle(das: decidedActionStyle) {
                hitAry.append(eachMove)
            }
        }
        
        derivedMoveAry = hitAry
        
        
        // ここ、 derivedMoveAryが空だと、一回も実行されない
        for each in derivedMoveAry {
//            print("ふつーの攻撃 抽出ささされたわざは \(each.name) だぞ")
        }
        
        // ↑の関数により、わざ候補が derivedMoveAryに格納されたはずなので、
        // 相手のとくせいが ふゆう なら、このタイミングでわざ候補の中から"じしん"をremoveすればよい
        
        if myPokemon.ability == .levitate {
            
            derivedMoveAry = derivedMoveAry.filter({$0.name != "Earthquack"})
//            print("除去後の相手の抽出されたこうげきリストは　\(derivedMoveAry) だぞ！")
        }
        
        
        // 同じように、ねこだましも1ターンめにしか出さないようにしないと くそ弱い
        if turn != foePokemon.appeardTurn + 1 {
            
            derivedMoveAry = derivedMoveAry.filter({$0.name != "Fake Out"})
            
//            print("これは 猫騙し判定 ふつーの攻撃様式だ")
            
            for each in derivedMoveAry {
//                print("抽出pocoわざは \(each.name) だぞ")
            }
        }
        

        
        
        
    }
    
    // MARK: 以下、各「ふるまい」内で実行される行動様式のまとめ
    
    // 行動様式1: quickAttackForfatalBlow(とどめの先制技)
    func quickAttackForfatalBlow() {
        
        myBVC.enqueue(reveivedStr: "とどめの 先制技!")
        
        myBVC.outputBattleMessageLikeTypeWriter()

        
        searchMoveByBehavior()

        
        if derivedMoveAry.isEmpty {
            // 途中で switch 大丈夫？
            //decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            
            normalAttackMove()
            
            return
            
        } else {
            
            var tmpMoveAry: [Int] = []
            
            for derivedMove in derivedMoveAry {
                
                tmpMoveAry.append(identifyMoveNo(move: derivedMove))
            }
            
            if tmpMoveAry.isEmpty { // ゆうて、ここはありえないはず...
                decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            } else {
                decidedFoeActionNo = tmpMoveAry[Int(arc4random_uniform(UInt32(tmpMoveAry.count)))] + 1
            }
        }
        
        
        
    }
    
    // 行動様式2: aggressiveWeakPointAttack(無鉄砲な弱点攻撃)
    func aggressiveWeakPointAttack() {
        
        myBVC.enqueue(reveivedStr: "無鉄砲な 弱点攻撃!")
        
        myBVC.outputBattleMessageLikeTypeWriter()
        
        
        searchMoveByBehavior()
        
        if derivedMoveAry.isEmpty {
            
//            decidedFoeActionNo = Int(arc4random_uniform(4)) + 1 // 見つからなかった場合は、ランダム
            
            // こんなふうに、途中で他の行動様式に移るには問題ないだろうか？
            normalAttackMove()
            
            return

            
        } else {
            
            var tmpMoveAry: [Int] = []
            
            for derivedMove in derivedMoveAry {
                tmpMoveAry.append(identifyMoveNo(move: derivedMove) + 1)
            }
            
            if tmpMoveAry.isEmpty { // ゆうて、ここはありえないはず...
                decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            } else {
                // 抽出されたわざの中から、ランダムで実行
                decidedFoeActionNo = tmpMoveAry[Int(arc4random_uniform(UInt32(tmpMoveAry.count)))]
            }
        }
        
    }
    
    // 行動様式3: pokemonChangeToGoodAffinityType(相性有利なポケモンにチェンジする)
    func pokemonChangeToGoodAffinityType() {
        
        myBVC.enqueue(reveivedStr: "相性有利なポケモンへチェンジ!")
        myBVC.outputBattleMessageLikeTypeWriter()
        
        let changeable: (changable: Bool, count: Int) = self.isChangable()

        if changeable.changable == false { // 既に2体ひんしで、チェンジ不可なら
            
            //decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            
            // こんなふうに、途中で他の行動様式に移るには問題ないだろうか？
            normalAttackMove()
            
            return
            
        } else {
//            judgeWhichPokemonIsSuitable()
            decidedFoeActionNo = 5 // ポケモンチェンジ
        }
    }
    
    
    // 行動様式4. ふつうに攻撃わざを繰り出す
    func normalAttackMove() {
        
        decidedActionStyle = .normalAttackMove

        
        myBVC.enqueue(reveivedStr: "ふつうに 攻撃！")
        myBVC.outputBattleMessageLikeTypeWriter()
        
        
        searchMoveByDecidedActionStyle()
        
        
        if derivedMoveAry.isEmpty {
            
            decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            
        } else {
            
            var tmpMoveAry: [Int] = []
            
            for derivedMove in derivedMoveAry {
                tmpMoveAry.append(identifyMoveNo(move: derivedMove) + 1)
            }
            
            if tmpMoveAry.isEmpty { // ゆうて、ここはありえないはず...
                decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            } else {
                decidedFoeActionNo = tmpMoveAry[Int(arc4random_uniform(UInt32(tmpMoveAry.count)))]
            }
        }
        
    }
    
    
    // 行動様式null: ヌル
    func null() {
        
        myBVC.enqueue(reveivedStr: "ヌル!")
        
        myBVC.outputBattleMessageLikeTypeWriter()
        
        var KOcount = 0
        
        for x in judge.battleField.foeParty {
            
            if x.HP <= 0 {
                KOcount += 1
            }
        }
        
        if KOcount == 2 {
            decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            
        } else {
            
            if Int(arc4random_uniform(100)) < 0 {
                
                decidedFoeActionNo = 5
                
            } else {
                decidedFoeActionNo = Int(arc4random_uniform(4)) + 1
            }
        }
    }
    
    
    
    var dynamicIndex = 0 // 0〜2に動き、相手の交換先ポケモンを指し示すidxになってくれるはずや...
    
    
    // ポケモンチェンジ時、どのポケモンにチェンジするか？を解析する関数
    
    func judgeWhichPokemonIsSuitable() -> Int {
        
        let foeParty = [judge.battleField.foePokemon1, judge.battleField.foePokemon2, judge.battleField.foePokemon3]
        
        // 有利・不利度
        var takeAdvPointOfFOEPokemon1: Double = 0
        var takeAdvPointOfFOEPokemon2: Double = 0
        var takeAdvPointOfFOEPokemon3: Double = 0
        
        var pointAary = [takeAdvPointOfFOEPokemon1, takeAdvPointOfFOEPokemon2, takeAdvPointOfFOEPokemon3]
        
        
        func generateChangeToNo(ary: inout [Double]) -> Int {
        
            var tplAry: [(idx: Int, aisyou: Double)] = []
            
//              var aisyouAry: [Double] = []
            
            for (idx, _) in ary.enumerated() {
                
              // 敵のポケモンは、ユーザーのポケモンにとって有利か？(有利度) 理論上は 2 + 2 + 2 + 2 = 最大8になるはず
              let yuurido = Chemistry.chemistry[foeParty[idx].type1.rawValue][myPokemon.type1.rawValue] +
                            Chemistry.chemistry[foeParty[idx].type1.rawValue][myPokemon.type2.rawValue] +
                            Chemistry.chemistry[foeParty[idx].type2.rawValue][myPokemon.type1.rawValue] +
                            Chemistry.chemistry[foeParty[idx].type2.rawValue][myPokemon.type2.rawValue]
                    
                            // ユーザーのポケモンは、敵にとって不利か？(不利度)大きいほど不利 理論上は 2 + 2 + 2 + 2 = 最大8になるはず
               let furido = Chemistry.chemistry[myPokemon.type1.rawValue][foeParty[idx].type1.rawValue] +
                            Chemistry.chemistry[myPokemon.type1.rawValue][foeParty[idx].type2.rawValue] +
                            Chemistry.chemistry[myPokemon.type2.rawValue][foeParty[idx].type1.rawValue] +
                            Chemistry.chemistry[myPokemon.type2.rawValue][foeParty[idx].type2.rawValue]
                    
                    // 有利度が高いほど有利で、不利度が高いほど不利。なのでこう評価することにした。
                    // この aisyou が最大のものを、交換先に指定すると、タイプの理屈上では有利な交換となるはず...
                    let aisyou = yuurido + (8 - furido)
                    
                    // 理論上は最大16になる
//                    print("\(myPokemon.name)に対しての\(foeParty[idx].name)の相性: → \(aisyou)ポイント。")
                
                    tplAry.append((idx, aisyou))
//                aisyouAry.append(aisyou)
                
            }
            
//            print("\(tplAry) だべさ")
            
//            aisyouAry.max()

            // aisyou値で tplAryをソートしたいだけ。どう書きゃいいの
            
            tplAry = tplAry.sorted(by: {$0.aisyou > $1.aisyou})
            
//            print("ソートされて、 \(tplAry) に なった")
            
            // もし、敵ポケモン[0]が チェンジ先に指定できない場合(ひんし / 既に出ている)場合、
            // 当然、他のポケモンが指定されなければならない。


            
            var flag = false
            
            var dassyutuCount = 0 // 無限ループになるのが怖いので、脱出用の変数です
            
            while flag == false && dassyutuCount < 10 {
                
//                print("現在の敵ポケモン 交換先idx: \(dynamicIndex)")

                
                if self.foePokemonAry[tplAry[dynamicIndex].idx].HP <= 0 {
                    
//                    print("\(foePokemonAry[tplAry[dynamicIndex].idx].name)は ひんしで たたかえない！")
                    
                    dynamicIndex += 1
                    
                    dassyutuCount += 1
                    
                } else if self.foePokemonAry[tplAry[dynamicIndex].idx] == judge.battleField.foeBattlePokemon {
                        
//                    print("\(foePokemonAry[tplAry[dynamicIndex].idx].name)は もう 場に でています")
                    
                    dynamicIndex += 1
                    
                    dassyutuCount += 1

                    
                } else {
                    
                    flag = true
                }
            }
            
            // わかりにくすぎるが、この dynamicIndexは、既にソートされた配列 tplAryに対してのidxである...
//            print("結局選ばれた 敵ポケモン 交換先idx: \(dynamicIndex)だよ。おつかれ")

            // これなんか　おかしい いったんかいひ
            //return tplAry[dynamicIndex].idx
            
            return tplAry[dynamicIndex].idx
            
            
            }
        
            return generateChangeToNo(ary: &pointAary)
        }
    
    
    
    
    


} // クラスの終了





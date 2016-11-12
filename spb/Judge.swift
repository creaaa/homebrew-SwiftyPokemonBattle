
import Foundation
import AudioToolbox

extension Int {
    
    var hantenInt: Int {
        if self == 1 {
            return 0
        } else {
            return 1
        }
    }
    
    var outputBool: Bool {
        
        if self == 0 {
            return true
        } else if self == 1 {
            return false
        }
        
        return false
    }
}


class Judge {

//    現在のターン数
//    味方・敵の残りポケモン数
//    味方・敵の場のポケモンのHP
//    味方・敵の場のポケモンのMAXHP
//    味方・敵の場のポケモンのLv
//    味方・敵の場のポケモンの状態異常
    
    var tmp_Turn = 0
    
    var tmp_myPokemonRestCount = 0
    var tmp_foePokemonRestCount = 0
    
    var tmp_myPokemonName = ""
    var tmp_myPokemonHP = 0
    var tmp_myPokemonMAXHP = 0
    var tmp_myPokemonLv = 0
    var tmp_myPokemonBadStatus: BadStatus = .null
    
    var tmp_foePokemonName = ""
    var tmp_foePokemonHP = 0
    var tmp_foePokemonMAXHP = 0
    var tmp_foePokemonLv = 0
    var tmp_foePokemonBadStatus: BadStatus = .null
    
    
    func storeValueToTmpVar() {
        
        tmp_Turn = turn
        
        var myKOCount = 0
        
        for x in judge.battleField.myParty {
            
            if x.HP <= 0 {
                myKOCount += 1
            }
            
        }
        
        tmp_myPokemonRestCount = 3 - myKOCount
        
        var foeKOCount = 0
        
        for x in judge.battleField.foeParty {
            
            if x.HP <= 0 {
                foeKOCount += 1
            }
        }
        
        tmp_foePokemonRestCount = 3 - foeKOCount
        
        tmp_myPokemonName = battleField.myBattlePokemon.name
        tmp_myPokemonHP = battleField.myBattlePokemon.HP
        tmp_myPokemonMAXHP = battleField.myBattlePokemon.MAXHP
        tmp_myPokemonLv = battleField.myBattlePokemon.lv
        tmp_myPokemonBadStatus = battleField.myBattlePokemon.badStatus
        
        tmp_foePokemonName = battleField.foeBattlePokemon.name
        tmp_foePokemonHP = battleField.foeBattlePokemon.HP
        tmp_foePokemonMAXHP = battleField.foeBattlePokemon.MAXHP
        tmp_foePokemonLv = battleField.foeBattlePokemon.lv
        tmp_foePokemonBadStatus = battleField.foeBattlePokemon.badStatus
    }
    
    

    var selectedMyPokemon1: Pokemon
    var selectedMyPokemon2: Pokemon
    var selectedMyPokemon3: Pokemon
  
    // JudgeはBattleFieldの参照を持つ
    // ここ、letからvarにした。なぜなら　BattleFieldを クラスから構造体にしたからね
    var battleField: BattleField
    
    
    var randIdx: [Int] = []
    
    
    
    // MARK: 敵ポケモンは ここでセットできますよ
    // ランダムマッチの際はこちら
    
    init(pokeAry: [Pokemon]) {
        
        self.selectedMyPokemon1 = pokeAry[0]
        self.selectedMyPokemon2 = pokeAry[1]
        self.selectedMyPokemon3 = pokeAry[2]
        
        
        // これは、参照渡しされてしまうのでHPなど、すべてのデータを共有してしまう。あかん。
//        self.battleField = BattleField(myPokemon1: pokeAry[0], myPokemon2: pokeAry[1], myPokemon3: pokeAry[2], foePokemon1: repository.Pokemons[6], foePokemon2: repository.Pokemons[8],foePokemon3: repository.Pokemons[3])
        

//        for cnt in 1...3 {
//            
//            while randIdx.count < cnt {
//            
//                let rand = Int(arc4random_uniform(10))
//                
//                if randIdx.index(of: rand) == nil {
//                    randIdx.append(rand)
//                } else {
//                    continue
//                }
//            }
//        }
//        
//        print("選ばれたidxは \(randIdx) です")
        
        
        var randIdx: [Int] = []
        
        for cnt in 1...3 {
            
            while randIdx.count < cnt {
                
                let rand = Int(arc4random_uniform(6))
                
                if randIdx.index(of: rand) == nil {
                    randIdx.append(rand)
                } else {
                    continue
                }
            }
        }
        
        
        // 11/11 21:53 一瞬だけ相手をコジョンドに
        // やばくなったら　もどす
        

        self.battleField = BattleField(
                               myPokemon1: pokeAry[0],
                               myPokemon2: pokeAry[1],
                               myPokemon3: pokeAry[2],
                               foePokemon1: foePokemonAry[randIdx[0]],
                               foePokemon2: foePokemonAry[randIdx[1]],
                               foePokemon3: foePokemonAry[randIdx[2]]
                           )
        
    }
    
    
    // 引数0で実行され、UserDefaultに保存されたポケモンからjudgeをイニシャライズしたい場合はこっちが実行される
    init(storedPokeAry: [Pokemon]) {
        
        self.selectedMyPokemon1 = storedPokeAry[0]
        self.selectedMyPokemon2 = storedPokeAry[1]
        self.selectedMyPokemon3 = storedPokeAry[2]
        
        
        
        // これ　だめよーだめだめ 11/9 11:00に消した
//        self.battleField = BattleField(myPokemon1: storedPokeAry[0], myPokemon2: storedPokeAry[1], myPokemon3: storedPokeAry[2], foePokemon1: repository.Pokemons[0], foePokemon2: repository.Pokemons[1],foePokemon3: repository.Pokemons[2])

        
        
        var randIdx: [Int] = []
        
        for cnt in 1...3 {
            
            while randIdx.count < cnt {
                
                let rand = Int(arc4random_uniform(6))
                
                if randIdx.index(of: rand) == nil {
                    randIdx.append(rand)
                } else {
                    continue
                }
            }
        }
        
        
        
        self.battleField = BattleField(
            
            myPokemon1: storedPokeAry[0],
            myPokemon2: storedPokeAry[1],
            myPokemon3: storedPokeAry[2],
            
            foePokemon1: foePokemonAry[randIdx[0]],
            foePokemon2: foePokemonAry[randIdx[1]],
            foePokemon3: foePokemonAry[randIdx[2]]
        )
        
        
    }
    
    
    
    // ターン処理の途中で一時的に格納しておきたい「与ダメージ」
    var tmpDamage: Int = 0
    

    // わざの処理種を受け取る
    //var receivedMoveProcess: MoveProcess = .null
    var receivedMoveProcess: [MoveProcess] = [.null]
    
    
    // わざ以外の効果を受け取る
    var receivedEffectProcess: EffectProcess = .null
    
    
    // 割込処理群2,3用
    
    // 「自分のポケモンのわりこみ処理」を受け取る
    var receivedMyPokemonInteruptionProcess: [StatusChange] = [.null]
    
    // 「相手のポケモンのわりこみ処理」を受け取る
    var receivedFoePokemonInteruptionProcess: [StatusChange] = [.null]
    
    
    
    // ああ、結局つくってしまった。。。自分の行動を管理
    var myAction = 1
    
    
    // 敵の行動を管理
    var foeAction = 1
    
    // あいてにわざを 命中させたか？(falseだと とびひざげりで反動ダメージを食らう)
    var couldHitMove = true
    
    
    
    // 今、どっちのターンかを司る
    // true : 自分のターン、 false : 相手のターン
    var whoIsTurn: Bool = true

    
    // MARK: initiateTurnProcess
    func initiateTurnProcess(moveNo: Int) {
        
        // 0. ポケモンチェンジ
        if moveNo == 5 {
//            pokemonChange()
            appearField()
        }

        if foeAction == 5 {
            foePokemonChange()
            appearField()
        }
        
        // 0.5 メガシンカ
        
        if false {
            // megaRevolution()
        }
        
        
        // 1. 行動順に従って行動
        judgeSpeed(moveNo: moveNo)
        
        // 99. 強制ポケモンチェンジ
        forcedPokemonChange()
        
    } // end of initiateTurnProcess()
    
    
    
    // MARK: 割込処理群  (ダメージ計算時、状態異常発生時、ターンエンド時、etc...)
    
    // 処理群1: 状態異常が付着した(シンクロ用)
    
    func interuptionProcessWhenBadStatusSticked() {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
//        let turnNo = whoIsTurn ? 0 : 1
        
        //print("たったいま トレーナー \(turnNo)の 状態異常発生由来 わりこみ処理 入りました")
        
        //print("***** わりこみ処理 開始 *****")
        
        receivedMyPokemonInteruptionProcess = [self.battleField.myBattlePokemon.manifestInteruptionProcessByBadStatus()]
        
        receivedFoePokemonInteruptionProcess = [self.battleField.foeBattlePokemon.manifestInteruptionProcessByBadStatus()]

        
        //print("自分のポケモン: 受け取ったわりこみ処理は \(receivedMyPokemonInteruptionProcess)です")
        //print("相手のポケモン: 受け取ったわりこみ処理は \(receivedFoePokemonInteruptionProcess)です")
        
        executeInteruptionProcessWhenBadStatusSticked()
        
        //print("***** わりこみ処理 終了 *****")
    }
    
    
    func executeInteruptionProcessWhenBadStatusSticked() {

        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let processAry = [receivedMyPokemonInteruptionProcess, receivedFoePokemonInteruptionProcess]
        
        for order in 0...1 {
            // 受け取った割込処理の実効を発動
            // まずは1ループめで「自分のポケモンの割込処理」を最初に処理。次に2ループめで「相手のポケモンの割込処理」を処理。
            for eachInteruptionProcess in processAry[order] {

                switch eachInteruptionProcess {
                    case .synchronize:
                        switch turnNo {
                        case 0:
                            if battleField.battleFieldPokemonArray[turnNo].badStatus != .null && battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .null {
                                
                                battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus = battleField.battleFieldPokemonArray[turnNo].badStatus
                                
                                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は あいての シンクロで \(battleField.battleFieldPokemonArray[turnNo].badStatus)に なってしまった！")
                            } else {
                                //print("いま、自分のターン。条件を よく見よう。なにか ちがうかも")
                            }
                        
                        case 1:
                            
                            if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus != .null && battleField.battleFieldPokemonArray[turnNo].badStatus == .null {
                                
                                battleField.battleFieldPokemonArray[turnNo].badStatus = battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus
                                
                                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は あいての シンクロで \(battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus)に なってしまった！")
                            } else {
//                                print("今、相手のターン。条件を よく見よう。なにか ちがうかも")
                            }
                         
                        default:
                            print("Irregular!")
                        } // inner switch
                    
                    default:
                        print("")
                } // outer switch
            } // inner for
        } // outer for
    
        // ここで、 nullにセットし直すのが無難か。
        receivedMyPokemonInteruptionProcess = [.null]
        receivedFoePokemonInteruptionProcess = [.null]
    
    }
    
    
    // 処理群2: ダメージ計算時(みちづれ、さめはだ用)
    
    func interuptionProcessWhenDamageCalculationOccured(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
//        let turnNo = whoIsTurn ? 0 : 1
        
        //print("たったいま トレーナー \(turnNo)の ダメージ計算時 わりこみ処理 入りました")
        
        //print("***** わりこみ処理 開始 *****")
        
        receivedMyPokemonInteruptionProcess = self.battleField.myBattlePokemon.manifestInteruptionProcessByDamageCalculation()
        receivedFoePokemonInteruptionProcess = self.battleField.foeBattlePokemon.manifestInteruptionProcessByDamageCalculation()
        
        //print("自分のポケモン: 受け取ったわりこみ処理は \(receivedMyPokemonInteruptionProcess)です")
        //print("相手のポケモン: 受け取ったわりこみ処理は \(receivedFoePokemonInteruptionProcess)です")
        
        executeInteruptionProcessWhenDamageCalculationOccured(moveNo: moveNo)
        
        //print("***** わりこみ処理 終了 *****")
    }
    
    
    func executeInteruptionProcessWhenDamageCalculationOccured(moveNo: Int) {
    
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let processAry = [receivedMyPokemonInteruptionProcess, receivedFoePokemonInteruptionProcess]
        
        // 1ループ目で自分、 2ループ目で相手の処理
        for order in 0...1 {
            
            
            for eachInteruptionProcess in processAry[order] {
            
                switch eachInteruptionProcess {
                
                    // 「ステータス変化」起因の処理リスト
                    case .destinyBond(let count):
                        
                        
                        switch whoIsTurn {
                            // 今、自分のターン
                            case true:
                            
                                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP <= 0 {
                                    
                                    if count == 1 {
                                        
                                        judge.storeValueToTmpVar()
                                        
                                        battleField.battleFieldPokemonArray[turnNo].HP = 0
                                        
                           // ここ　おかしい。よくみろ
//        myBVC.HPchangeAnimeForItself(tmp_myPokeHP: &tmp_myPokemonHP, tmp_foePokeHP: &tmp_foePokemonHP, damage: 999, whichTurn: whoIsTurn)
                                        
                                        
                                        
                                        
                                        
                                        
                                        //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nあいてを みちづれに した！")
                                        
                                        let msg = lang ? "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nあいてを みちづれに した！" : "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) invited a journey to the netherworld!"
                                        
                                        
                                        myBVC.enqueue(reveivedStr: msg)
                                        
                                        myBVC.outputBattleMessageLikeTypeWriter()
                                        
                                        judge.storeValueToTmpVar()
                                        
                                        // お互い最後の1体でみちづれ相打ちの場合、みちづれ使用者が敗者となる
                                        judgeIbeatFoe()
                                        judgeIamBeaten()
                                      
                                    }  // if みちづれカウントが 1 なら
                                    
                                    
                                    
                            } // if
                                
                            
                            case false:
                            
                                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP <= 0 {
                                    
                                    if count == 1 {
                                    
                                        battleField.battleFieldPokemonArray[turnNo].HP = 0
                                        
                                        //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nあいてを みちづれに した！")
                                        
                                        let msg = lang ? "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nあいてを みちづれに した！" : "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) invited a journey to the netherworld!"
                                        
                                        
                                        myBVC.enqueue(reveivedStr: msg)
                                        
                                        myBVC.outputBattleMessageLikeTypeWriter()
                                        
                                        judge.storeValueToTmpVar()
                                        
                                        
                                        // お互い最後の1体でみちづれ相打ちの場合、みちづれ使用者が敗者となる
                                        judgeIamBeaten()
                                        judgeIbeatFoe()
                                    
                                    }  // if みちづれカウントが 1 なら
                            
                                    
                                    
                                } // if
                        }  // switch whoIsTurn
                        
                        
              
                    
                    
                    // 「とくせい」起因の処理リスト
                    case .roughskin:
                        
                        
                        //　条件1: 相手のターン時に 条件2: 相手のわざが直接攻撃なら
                        if turnNo != order && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].isDirect == true {
                        
//                        print("さめはだ前: \(battleField.battleFieldPokemonArray[turnNo].HP )")
                        
                        if battleField.battleFieldPokemonArray[turnNo].HP > 0 {
                        
                            battleField.battleFieldPokemonArray[turnNo].HP -= battleField.battleFieldPokemonArray[turnNo].MAXHP / 8
                            
                            //print("\(battleField.battleFieldPokemonArray[turnNo].name)は\nさめはだで きずついた！")
                                
                            
                            let msg = lang ? "\(battleField.battleFieldPokemonArray[turnNo].name)は\nさめはだで きずついた！" : "\(battleField.battleFieldPokemonArray[turnNo].name) was injured by Rough Skin!"
                            
                            myBVC.enqueue(reveivedStr: msg)
                            
                            myBVC.outputBattleMessageLikeTypeWriter()
                            
                            myBVC.HPchangeAnimeForItself(tmp_myPokeHP: &tmp_myPokemonHP, tmp_foePokeHP: &tmp_foePokemonHP, damage: tmpDamage, whichTurn: whoIsTurn)
                            
                            judge.storeValueToTmpVar()
                            
                        }
                            

                        if battleField.battleFieldPokemonArray[turnNo].HP <= 0 {
                            
                            //print("\(battleField.battleFieldPokemonArray[turnNo].name)は たおれた！")
                            
                            
                            let msg = lang ? "\(battleField.battleFieldPokemonArray[turnNo].name)は たおれた！" : "\(battleField.battleFieldPokemonArray[turnNo].name) was fainted！"
                            
                            myBVC.enqueue(reveivedStr: msg)
                            
                            myBVC.outputBattleMessageLikeTypeWriter()
                            
                            judge.storeValueToTmpVar()
                            
                            
                            isDead()
                        }
                        
                            
                            
                        } else {
                            //print("間接攻撃 もしくは 自分の攻撃なので さめはだ 不発！")
                    }
                    
                    case .seidenki:
                    
                    //　条件1: 相手のターン時に 条件2: 相手のわざが直接攻撃なら
                    if turnNo != order && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].isDirect == true {
                        
                        
                        if battleField.battleFieldPokemonArray[turnNo].type1 == .electric || battleField.battleFieldPokemonArray[turnNo].type2 == .electric {
                            
                            // 電気タイプは まひじょうたいに ならない
                            
                        } else if battleField.battleFieldPokemonArray[turnNo].badStatus == .null {
                            
                            // せいでんきは 30%の確率でしか 発動しない...(11/9まで知らなかった)
                            if Int(arc4random_uniform(100)) < 30 {
                            
                                battleField.battleFieldPokemonArray[turnNo].badStatus = .palalyze
                                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は\nまひしてしまった！")
                                
                                
                                if battleField.battleFieldPokemonArray[turnNo].HP > 0 {
                                    
    //                                myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nせいでんきで まひしてしまった！")
                                    
                                    
                                    
                                    let msg = lang ? "\(battleField.battleFieldPokemonArray[turnNo].name)は\nせいでんきで まひしてしまった!" : "\(battleField.battleFieldPokemonArray[turnNo].name) was palalyzed by Static!"
                                    
                                    myBVC.enqueue(reveivedStr: msg)
                                    
                                    
                                    myBVC.outputBattleMessageLikeTypeWriter()
                                    
                                    judge.storeValueToTmpVar()
                                    
                                }
                                
                                // 実装パターンB: 汎用的だが、成功する試しはない。
                                // !!!: わりこみ処理(主にシンクロを意識して)
                                // ここに書くのは、どうも筋が悪い気がする。
                                // 常によい設計を探し、ここの記述を変えることも厭うな。
                                interuptionProcessWhenBadStatusSticked()

                            } // 確率30% のスコープ 終了
                        
                            
                        } else {
                            //print("相手は既にバステじゃね？ 故に相手を 静電気でまひさせるも何も ないんだよな")
                        }
                        
                    } else {
                        //print("間接攻撃 もしくは 自分の攻撃なので せいでんき 不発！")
                    }
                    
                    default:
                        print("Irregular!")
                }
            }
        }
        
        // ここで、 nullにセットし直すのが無難か。
        // →いや、だめ。ここは 1. 味方ターンの攻撃時 2. 敵ターンの攻撃時の2回発生するのだから、
        // 1回めのときりせっとされてはもともこもない。つまりターン終了時にリセット？
        
        // →　いや、やっぱ毎回リセットされても大丈夫だ。たぶん。
        receivedMyPokemonInteruptionProcess = [.null]
        receivedFoePokemonInteruptionProcess = [.null]
    
    
    }
    
    
    // 処理群3: ターンエンド時の割込処理
    func interuptionProcessWhenTurnEnd() {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
//        let turnNo = whoIsTurn ? 0 : 1
        
        //print("たったいま ターンエンド時の わりこみ処理 入りました")
        
        receivedMyPokemonInteruptionProcess = self.battleField.myBattlePokemon.manifestInteruptionProcessByTurnEnd()
        receivedFoePokemonInteruptionProcess = self.battleField.foeBattlePokemon.manifestInteruptionProcessByTurnEnd()
        
        //print("自分のポケモン: 受け取ったわりこみ処理は \(receivedMyPokemonInteruptionProcess)です")
        //print("相手のポケモン: 受け取ったわりこみ処理は \(receivedFoePokemonInteruptionProcess)です")
        
        executeInteruptionProcessByTurnEnd()
        
    }
    
    
    func executeInteruptionProcessByTurnEnd() {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
//        let turnNo = whoIsTurn ? 0 : 1
        
        let processAry = [receivedMyPokemonInteruptionProcess, receivedFoePokemonInteruptionProcess]
        
        // 1ループ目で自分、 2ループ目で相手の処理
        for order in 0...1 {
            // 受け取った割込処理の実効を発動
            for eachInteruptionProcess in processAry[order] {
                
                switch eachInteruptionProcess {
                    
                    case .yawn(let count):

                        //print(count)
                    
                        
//                        let oge = eachInteruptionProcess
                        
//                        for unun in battleField.battleFieldPokemonArray[order].statusChange {

                            if count >= 3 {
                                
                                battleField.battleFieldPokemonArray[order].badStatus = .sleep
                                //print("\(battleField.battleFieldPokemonArray[order].name)は\nねむってしまった！")
                                
                                if battleField.battleFieldPokemonArray[order].HP > 0 {
                                    
//                                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[order].name)は\nねむってしまった！")

                                    
                                    let msg = lang ? "\(battleField.battleFieldPokemonArray[order].name)は\nねむってしまった!" : "\(battleField.battleFieldPokemonArray[order].name) got slept!"
                                    
                                    myBVC.enqueue(reveivedStr: msg)
                                    
                                    
                                    
                                    
                                    myBVC.outputBattleMessageLikeTypeWriter()
                                    
                                    judge.storeValueToTmpVar()
                                }
                                
                            } else {
                                //print("むずー")
                            }
                        
//                        }
                    
                    default:
                        print("Irregular!")
                } // switch
            } // eachInteruptionProcess for
        } // outer for
        
        
        // ここで、 nullにセットし直すのが無難か。
        // →いや、だめ。ここは 1. 味方ターンの攻撃時 2. 敵ターンの攻撃時の2回発生するのだから、
        // 1回めのときりせっとされてはもともこもない。つまりターン終了時にリセット？
        
        // →　いや、やっぱ毎回リセットされても大丈夫だ。たぶん。
        receivedMyPokemonInteruptionProcess = [.null]
        receivedFoePokemonInteruptionProcess = [.null]
        
    }  // func
    
    
    
    // MARK: ポケモンチェンジ

    // 0.A ポケモンチェンジ
    func pokemonChange() {
    
        ////////////////////
        // judge(コントローラー) → ビュー → judgeに戻ってくる、の理想的な例。
        // ビューはただビューをプリントし、↓のpokemonChangeImplement()を実行しろ、っていってくる。
        // 1周ぐるっとまわって　他に影響を与えず　ただ戻ってくる、という例。理解しろ。
        /////////////////////
        
        let pokemonChangeView: View = PokemonChangeView()
        
        pokemonChangeView.execute()
    }
    
    
    // changeTo: 0:1体め、 1: 2体め、 2: 3体め
    func pokemonChangeImplement(changeTo: Int) {
        
        if battleField.myParty[changeTo].HP <= 0 {
            
            //print("\(battleField.myParty[changeTo].name)は ひんしで たたかえない！")
            
//            myBVC.enqueue(reveivedStr: "\(battleField.myParty[changeTo].name)は ひんしで たたかえない！")
            
            
            let msg = lang ? "\(battleField.myParty[changeTo].name)は ひんしで たたかえない!" : "\(battleField.myParty[changeTo].name) can't battle!"
            
            myBVC.enqueue(reveivedStr: msg)
            
            
            
            
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            pokemonChange()
            
        } else if (battleField.myBattlePokemon == battleField.myParty[changeTo]) {
            
            //print("\(battleField.myParty[changeTo].name)は もう 場に でています")
            
//            myBVC.enqueue(reveivedStr: "\(battleField.myParty[changeTo].name)は もう 場に でています")
            
            
            
            let msg = lang ? "\(battleField.myParty[changeTo].name)は もう 場に でています" : "\(battleField.myParty[changeTo].name) is already on the battlefield."
            
            myBVC.enqueue(reveivedStr: msg)
            
            
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            pokemonChange()
            
        } else {
            
            // 追記。ポケモンが場からひっこむとき、バフ・デバフLvを0にする処理。
            // これがうまくいってたら、「こんらん・メロメロ...」とかもここでリセットできるようにする。
            
            battleField.myBattlePokemon.buffDebuff.statsLVArray = [99,99,99,99,99]
            
            
            //print("もどれっ！ \(battleField.myBattlePokemon.name)！")
            
            // エンキュー
            
            if lang == true {
                myBVC.enqueue(reveivedStr: " もどれ！ \(battleField.myBattlePokemon.name)!")
            } else {
                myBVC.enqueue(reveivedStr: " \(battleField.myBattlePokemon.name), come back!")
            }
            
            
            
            
            
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            
            battleField.myBattlePokemon = battleField.myParty[changeTo]
            
            // battlePokemonArray も明示的に更新しないと、今のとこだめ。監視の仕組みが必要なんだ・・・
            battleField.battleFieldPokemonArray = [battleField.myBattlePokemon, battleField.foeBattlePokemon]
            
            // 新しいポケモンが場に出現したターンを設定。ねこだましのためだけに使われる。
            battleField.myBattlePokemon.appeardTurn = turn
            
            // ついでに、これでステータス変化をリセットできるのでは？？
            battleField.myBattlePokemon.statusChange = [.null]
            
            
            
            // ここ！！！！注意しろ！！！！！
            if judge.battleField.myBattlePokemon.HP > 0 {
                ViewManipulation.resetOutputColor()
            }
            
            
            
            
            
            //print("いってこい！ \(battleField.myBattlePokemon.name)！！")
            
            // エンキュー
            if lang == true {
                myBVC.enqueue(reveivedStr: " いってこい! \(battleField.myBattlePokemon.name)!")
            } else {
                myBVC.enqueue(reveivedStr: " Go! \(battleField.myBattlePokemon.name)!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            

            // 現在のパーティ
//            print("1体目: \(battleField.myParty[0].name) : \(battleField.myParty[0].HP) / \(battleField.myParty[0].MAXHP)")
//            print("2体目: \(battleField.myParty[1].name) : \(battleField.myParty[1].HP) / \(battleField.myParty[1].MAXHP)")
//            print("3体目: \(battleField.myParty[2].name) : \(battleField.myParty[2].HP) / \(battleField.myParty[2].MAXHP)")
            
            //print("現在のmy バトルポケモン: \(battleField.myBattlePokemon.name) : \(battleField.myBattlePokemon.HP) / \(battleField.myBattlePokemon.MAXHP)")
        }
    }
    
    
    // 0.B 敵がポケモンチェンジを選択した場合
    func foePokemonChange() {
        
        let myAI = AI(myPokemon: battleField.myBattlePokemon, foePokemon: battleField.foeBattlePokemon, foePokemonAry: battleField.foeParty)
        
        
        let nextFOEPokemonIdx = myAI.judgeWhichPokemonIsSuitable()
        

        let changeTo = Int(nextFOEPokemonIdx)

        
        // changeTo: 0:1体め、 1: 2体め、 2: 3体め
//        let changeTo = Int(arc4random_uniform(3))
        
        if battleField.foeParty[0].HP <= 0 && battleField.foeParty[1].HP <= 0 && battleField.foeParty[2].HP <= 0 {
            //print("相手のポケモンは　全員　ひんしです")
            judgeIbeatFoe()
        
        } else if battleField.foeParty[changeTo].HP <= 0 {
        
            //print("\(battleField.foeParty[changeTo].name)は ひんしで たたかえない！")
            foePokemonChange()
        
        } else if (battleField.foeBattlePokemon == battleField.foeParty[changeTo]) {
            
            //print("\(battleField.foeParty[changeTo].name)は もう 場に でています")
            foePokemonChange()
            
        } else {
            
            // 追記。ポケモンが場からひっこむとき、バフ・デバフLvを0にする処理。
            // これがうまくいってたら、「こんらん・メロメロ...」とかもここでリセットできるようにする。
            battleField.foeBattlePokemon.buffDebuff.statsLVArray = [99,99,99,99,99]
            
            
            // ここ、ポケモン死亡時の強制チェンジのときも出てるのはおかしい。
            // なんとか条件分岐で通常ポケモン時だけ表示できるようにしろ。。。 →　できました
            
            //print("相手は \(battleField.foeBattlePokemon.name)を ひっこめた！")
            
            // エンキュー
            
            if battleField.foeBattlePokemon.HP > 0 {
            
                if lang == true {
                    myBVC.enqueue(reveivedStr: "masaは\n\(battleField.foeBattlePokemon.name)を ひっこめた！")
                } else {
                    myBVC.enqueue(reveivedStr: "masa withdrew \(battleField.foeBattlePokemon.name)!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
            }
            
            
            battleField.foeBattlePokemon = battleField.foeParty[changeTo]
            
            // battlePokemonArray も明示的に更新しないと、今のとこだめ。監視の仕組みが必要なんだ・・・
            battleField.battleFieldPokemonArray = [battleField.myBattlePokemon, battleField.foeBattlePokemon]
            
            // 新しいポケモンが場に出現したターンを設定。ねこだましのためだけに使われる。
            battleField.foeBattlePokemon.appeardTurn = turn
            
            // ついでに、これでステータス変化をリセットできるのでは？？
            battleField.myBattlePokemon.statusChange = [.null]
            
            
            //print("masaは\n\(battleField.foeBattlePokemon.name)を くりだした！")
            
            // エンキュー
            if lang == true {
                myBVC.enqueue(reveivedStr: "masaは\n\(battleField.foeBattlePokemon.name)を くりだした!")
            } else {
                myBVC.enqueue(reveivedStr: "masa sent out \(battleField.foeBattlePokemon.name)!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            //print("現在の foe バトルポケモン: \(battleField.foeBattlePokemon.name) : \(battleField.foeBattlePokemon.HP) / \(battleField.foeBattlePokemon.MAXHP)")
        }
    }
    
    
    // ポケモンが場に出た瞬間に、とくせいの発動・ステロダメージ・死亡判定などが走る
    func appearField() {
        
        // とくせいの発動の実装 //
        // みかづきのまいの回復(強制ポケモンチェンジから呼び出された場合のみ発動) //
        // ステロダメージの実装(メガシンカ時から呼び出された場合は発動しない) //
        // ねばねばネット
        
        isDead()
    }
    
    // MARK: judge最大の責務であり、重厚長大なターン処理プロセス
    
    // 1. 行動順に従ってわざを発動
    
    func judgeSpeed(moveNo: Int) {
        
        // 自分と相手の両方が「ポケモンチェンジ」を選択した場合の処理
        if moveNo == 5 && foeAction == 5 {
            
            //print("両方のトレーナーが チェンジを選択した'パターンです" )
            
            // これを書かないと、あくびなどがおかしくなる
            statusChangeCountPlus()
            
            
            
            
            // いるか？わからん。けど念のため。
            whoIsTurn = true
            
            // 死亡判定 (新しく交換したポケモンがステロを踏んで自爆した、などが想定されるため)　書くな。バグの温床。
            //isDead()
            
            
            // 97 いらないかも？でも念のため
            statusChangeCountPlus()
            
            // 98. 毎ターン終了時の処理
            turnEnd()
            
        } else if moveNo == 5 {  // 自分が「ポケモンチェンジ」を選択していた場合
        
            //print("自分だけがポケモンチェンジを選択した'パターンです" )
            
            // 死亡判定 (新しく交換したポケモンがステロを踏んで自爆した、などが想定されるため) 書くな。バグの温床。
            //isDead()
            
            
            // これを書かないと、あくびなどがおかしくなる
            statusChangeCountPlus()
            
            
            whoIsTurn = false
            
            
            // ポケモンから → 審判 には、こうしてシグナルが送られる。ここに精通しよう
//            receivedMoveProcess = (battleField.myBattlePokemon.doMove(moveNo: moveNo))
//            print("受け取ったわざ処理は \(receivedMoveProcess)です")
            
            // 1.5 相手 : わざ発動
            moveExecuteProcess(moveNo: foeAction)
            
            
            // 3. 死亡判定 書くな。バグの温床。
            //isDead()
            
            
            // 97. カウント増減
            statusChangeCountPlus()
            
            // 98. 毎ターン終了時の処理
            turnEnd()
            
            
        // 敵が「ポケモンチェンジ」を選択した場合
        } else if foeAction == 5 {
            
            actOrder = false
            
            //print("'敵だけが ポケモンチェンジを 選択した'パターンです")
            
            // 死亡判定 (新しく交換したポケモンがステロを踏んで自爆した、などが想定されるため) 書くな。バグの温床。
//          isDead()
            
            
            // これを書かないと、あくびなどがおかしくなる
            statusChangeCountPlus()
            
            
            // 自分のターンになる
            whoIsTurn = true
            
            // ポケモンから → 審判 には、こうしてシグナルが送られる。ここに精通しよう
//            receivedMoveProcess = (battleField.myBattlePokemon.doMove(moveNo: moveNo))
//            print("受け取ったわざ処理は \(receivedMoveProcess)です")
            
            // 1.5. 自分: わざ発動
            
            moveExecuteProcess(moveNo: moveNo)
            
            
            // 3. 死亡判定　バグ　書くな
            // isDead()
            
            // 97. カウント増減
            statusChangeCountPlus()
            
            // 98. 毎ターン終了時の処理
            turnEnd()
            
            
        } else { // 両方とも「チェンジ」を選んでない(= 普通の処理)
            // わざの優先度・すばやさに応じて、行動順を決定
            judgeActionOrder(moveNo: moveNo, foeAction: foeAction)
        }
    }
        

    // 1.5
    func moveExecuteProcess(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        //print("たったいま トレーナー \(turnNo)の わざ発動処理(1.5) 入りました")
        
        //print("***** わざの発動 開始 *****")

        if turnNo == 0 {
            receivedMoveProcess = (battleField.myBattlePokemon.doMove(moveNo: moveNo))
        } else if turnNo == 1 {
            receivedMoveProcess = (battleField.foeBattlePokemon.doMove(moveNo: moveNo))
        }
        
        //print("受け取ったわざ処理は \(receivedMoveProcess)です")
        
        // 2. わざの実効を発動
        executeMoveProcessInstance(moveNo: moveNo)
        
        //print("***** わざの発動 終了 *****")
        
        // とびひざげりで使われるこのプロパティのリセット処理、ここで書けば、問題ない？？
        couldHitMove = true
        
    }
    
    

    // MARK:【わざ発動判定】 2. 受け取ったわざ信号をもとに、わざの実効を発動 (超エレガントな実装！！！)
    func executeMoveProcessInstance(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        // print("いま、\(turnNo)のターンだよ、間違いないね。")

        
        // 条件0-A: ねむりのめざめ判定(超簡略化しました)
        
        if battleField.battleFieldPokemonArray[turnNo].badStatus == .sleep {
            
            let rand = Int(arc4random_uniform(3))
            
            if rand == 0 {
                
                battleField.battleFieldPokemonArray[turnNo].badStatus = .null
                
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は\nめを さました！")
                
                
                if lang == true {
                    
                    let tmpStr = whoIsTurn ? "" : "てきの "

                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name)は\nめを さました!")
                } else {
                    
                    let tmpStr = whoIsTurn ? "" : "The opposite "

                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name) woke up!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
                
            } else {
                
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は\nぐうぐう ねむっている")
                
                if lang == true {
                    
                    let tmpStr = whoIsTurn ? "" : "てきの "
                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name)は\nぐうぐう ねむっている")
                } else {
                    
                    let tmpStr = whoIsTurn ? "" : "The opposite "
                    
                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name) is sleeping...")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
            
                return
                
            }
        }
        
        
        
        // 条件0-B:こおりの解凍判定(超簡略化しました)
        
        if battleField.battleFieldPokemonArray[turnNo].badStatus == .ice {
            
            let rand = Int(arc4random_uniform(4))
            
            // 本来、ここに書くべきではない気がする。
            // だってここに書いたら、「フレアドライブで氷を溶かしたけど、まひで動けない」とかがあありえるから。
            // 氷とかし判定が本来どこで行われるのか、謎...
            
            if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Flare Blitz" {
                
                battleField.battleFieldPokemonArray[turnNo].badStatus = .null
                
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)の\nこおりが とけた！")
                
                if lang == true {
                    
                    let tmpStr = whoIsTurn ? "" : "てきの "
                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name)は\nフレアドライブで こおりを とかした!")
                } else {
                    let tmpStr = whoIsTurn ? "" : "The opposite "
                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name) melted away its ice by Flare Blitz!")
                }
                
                
            
            } else if rand == 0 {
                
                battleField.battleFieldPokemonArray[turnNo].badStatus = .null
                
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)の\nこおりが とけた！")
                
                if lang == true {
                    let tmpStr = whoIsTurn ? "" : "てきの "
                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name)の\nこおりが とけた！")
                } else {
                    let tmpStr = whoIsTurn ? "" : "The opposite "
                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name)'s ice melt away!")
                }
                
                judge.storeValueToTmpVar()
                
                
            } else {
                
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は\nこおって しまって うごけない！")
                
                if lang == true {
                    let tmpStr = whoIsTurn ? "" : "てきの "

                myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name)は\nこおって しまって うごけない！")
                } else {
                    let tmpStr = whoIsTurn ? "" : "The opposite "
                    myBVC.enqueue(reveivedStr: "\(tmpStr)\(battleField.battleFieldPokemonArray[turnNo].name) can't move by its ice!")
                }
                
                judge.storeValueToTmpVar()
                
                return
                
            }
        }
        
        
        
        
        // 条件1: わざ発動者のHPが 0 ではない
        if battleField.battleFieldPokemonArray[turnNo].HP <= 0 {
            //print("ひんしなので わざは だせない！")
            return
        }
        
        
        // 条件3: わざ発動者が行動不能である
        if canMoveOrNot() == true {
            //print("わざ発動者は 行動不可！ わざは 発動しない！")
            return
        }
        
//        // 条件4: こんらん・メロメロ・まひで行動可能判定: 不可が出ていた場合、わざは発動しない
//        if battleField.battleFieldPokemonArray[turnNo].cantMove == true {
//            battleField.battleFieldPokemonArray[turnNo].cantMove = false
//            //print("行動可能判定: 不可！わざは発動しない！")
//            return
//        }
        

        // MARK: わざ発動の出力！！
        // エンキュー
        if battleField.battleFieldPokemonArray[turnNo].HP > 0 {
            
            let judgeEnemyTurn: String
            
            if lang == true {
                judgeEnemyTurn = whoIsTurn ? "" : "てきの "
            } else {
                judgeEnemyTurn = whoIsTurn ? "" : "The opposing "
            }
            
            judge.storeValueToTmpVar()
            
            if lang == true {
            myBVC.enqueue(reveivedStr: "\(judgeEnemyTurn)\(battleField.battleFieldPokemonArray[turnNo].name)の \(battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name)!")
            } else {
                myBVC.enqueue(reveivedStr: "\(judgeEnemyTurn)\(battleField.battleFieldPokemonArray[turnNo].name) used \(battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name)!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            
        }
        
        ////////////////////////////////////////////
        //
        // ↑　ここまで、「わざ自体が発動できなかった場合」
        
        // ↓  ここから、「わざ自体は発動できたが、なんらかの理由で命中しなかった場合」
        //
        ////////////////////////////////////////////
        
        
        // 条件2: 攻撃対象の相手のHPが 0 ではない (通常攻撃わざ や やどりぎのタネ等は、そもそも相手がいないと発動しない)
        
        // カテゴリ: ステータスわざ かつ 自分が対象のわざ の場合、命中判定は実行されない。
        if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].category == .status && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectTo == true {

            // このスコープに該当することで、以下はすべて無視してくれる。よってこの中には何も書かなくても良い。
        }
        
        else if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP <= 0 {
            //print("攻撃対象の 相手が いない！ うまく きまらなかった！")
            
            // エンキュー
            if lang == true {
                myBVC.enqueue(reveivedStr: "しかし うまく きまらなかった!")
            } else {
                myBVC.enqueue(reveivedStr: "But it's failed!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            return
        }
        
        // 条件5: 命中判定。ここをパスできなかった場合、わざは命中しない
        
        let rand = Int(arc4random_uniform(100))
        let accuracy = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].accuracy

        //print(rand)

        // 必中技は必ずヒット
        if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Aura Sphere" {
            //print("必中技なので 必ず当たります")
            // このスコープに該当することで、以下はすべて無視してくれる。よってこの中には何も書かなくても良い。
        }
            
        // 毒タイプがどくどくを使った場合、必ずヒット
        else if (battleField.battleFieldPokemonArray[turnNo].type1 == .poison || battleField.battleFieldPokemonArray[turnNo].type2 == .poison) && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Toxic" {
//            print("使用者は毒タイプなので 必ず当たります")
            // このスコープに該当することで、以下はすべて無視してくれる。よってこの中には何も書かなくても良い。
        }
            
        // カテゴリ: ステータスわざ かつ 自分が対象のわざ の場合、命中判定は実行されない。
        else if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].category == .status && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectTo == true {
            
//            print("けんまいとかやろ")
            
            // このスコープに該当することで、以下はすべて無視してくれる。よってこの中には何も書かなくても良い。
            
        }
            
        else if rand > accuracy // 通常の命中判定
        {
            //print("しかし \(battleField.battleFieldPokemonArray[turnNo].name)の こうげきは はずれた！")
            
            couldHitMove = false
            
            // エンキュー
            if lang == true {
                myBVC.enqueue(reveivedStr: "しかし \(battleField.battleFieldPokemonArray[turnNo].name)の こうげきは はずれた！")
            } else {
                myBVC.enqueue(reveivedStr: "But \(battleField.battleFieldPokemonArray[turnNo].name)'s attack missed!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            // とびひざげりの処理のためだけに、ここに書いてる。超ださい。
            if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "High Jump Kick" {
                recoil(moveNo: moveNo)
            }
            return
        } else {
            //print("命中判定: 通過")
        }
        
        
        // 条件6: こうかが ない みたいだ... ではないか？
        
        
        let chemistry1: Double = Chemistry.chemistry[battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].type.rawValue][battleField.battleFieldPokemonArray[turnNo.hantenInt].type1.rawValue]
        let chemistry2: Double = Chemistry.chemistry[battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].type.rawValue][battleField.battleFieldPokemonArray[turnNo.hantenInt].type2.rawValue]
        
        
        // カテゴリ: ステータスわざ かつ 自分が対象のわざ の場合、命中判定は実行されない。
        if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].category == .status && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectTo == true {
            
            // このスコープに該当することで、以下はすべて無視してくれる。よってこの中には何も書かなくても良い。
        }
            
        // どくどくがルカリオに「こうかが ない みたいだ...」ってでるのはなんか変なので、対処療法的に急遽作りました
            
        else if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Toxic" {
            
        }
        
        // このスコープをつくらないと、フェアリースキンでフェアリー化したノーマル技が、ゲンガーに対し「効果なし」になってしまう
        else if battleField.battleFieldPokemonArray[turnNo].ability == .pixilate && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].type == .normal {
            //
        }
        
        else if battleField.battleFieldPokemonArray[turnNo.hantenInt].ability == .levitate && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].type == .ground {
            //print("あいては ふゆうなので あたらない！")
            
            // エンキュー
            if lang == true {
                myBVC.enqueue(reveivedStr: "あいては ふゆうなので あたらない！")
            } else {
                myBVC.enqueue(reveivedStr: "No hit because the enemy is levitating!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            return
        }
        
        else if chemistry1 == 0.0 || chemistry2 == 0.0 {
            //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)には\nこうかが ない みたいだ...")
            
            couldHitMove = false
            
            // エンキュー
            if lang == true {
                myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)には\nこうかが ない みたいだ...")
            } else {
                myBVC.enqueue(reveivedStr: "It doesn't affect \(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            
            // とびひざげりの処理のためだけに、ここに書いてる。超ださい。
            if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "High Jump Kick" {
                recoil(moveNo: moveNo)
            }
            
            return
        }

        
        
        // サブ条件1: ねこだましの場合、場に出たターンじゃないと失敗する
        if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Fake Out" {
            
            if battleField.battleFieldPokemonArray[turnNo].appeardTurn + 1 != turn {
                //print("失敗！ねこだましは　初手のみ　だせる！")
                
                // エンキュー
                
                if lang == true {
                    
                    myBVC.enqueue(reveivedStr: "しかし うまく きまらなかった！(ねこだましは 初手のみ 成功する)")
                } else {
                    myBVC.enqueue(reveivedStr: "But it's failed! (Fake Out succeeds only the first move.)")
                }
                    
                myBVC.outputBattleMessageLikeTypeWriter()
                
                return
                    
            } else {
                
//                if lang == true {
//                    myBVC.enqueue(reveivedStr: "ねこだまし 成功!")
//                } else {
//                    myBVC.enqueue(reveivedStr: "Fake Out Succeeded!")
//                }
//                
//                myBVC.outputBattleMessageLikeTypeWriter()
            }
            
        }
        
        
        
        // 条件 1 - 6 を無事クリアできてはじめて、晴れてわざを発動できる！
        
        for eachMoveProcess in receivedMoveProcess {
        
            switch eachMoveProcess {
                case .giveDamage:
                    //print("ダメージ計算！")
                    giveDamage(moveNo: moveNo)
                case .healHP:
                    //print("HP回復！")
                    healHP()
                case .givePalalyze:
                    //print("あいてを まひさせる！")
                    givePalalyze(moveNo: moveNo)
                case .giveBurn:
                    //print("あいてを やけどさせる！")
                    giveBurn(moveNo: moveNo)
                case .giveIce:
                    //print("あいてを こおらせる！")
                    giveIce(moveNo: moveNo)
                case .giveSleep:
                    //print("あいてを ねむらせる！")
                    giveSleep(moveNo: moveNo)
                case .givePoison:
                    //print("あいてを どくにさせる！")
                    givePoison(moveNo: moveNo)
                case .recoil:
                    //print("自分にも 反動ダメージの 処理！\n(※実装上、とびひざげりを打つだけで表示されるので気にしないで)")
                    recoil(moveNo: moveNo)
                case .getBuffDebuff:
                    //print("バフデバフ！")
                    buffdebuff(moveNo: moveNo)
                case .makeDestinyBond:
                    //print("みちづれ実行！")
                    destinyBond()
                case .makeYawn:
                    //print("あくび！！")
                    yawn()
                case .makeFlinch:
                    //print("ひるませる！！")
                    makeFlinch(moveNo: moveNo)
                
                case .null:
                    print("Irregular!")
            }  // switch
        } // for
    } // executeMoveProcessInstance()
    
    
    // 2-A. 行動できるかどうかの判定(2.から呼び出される)
    func canMoveOrNot() -> Bool
    {
        
        //print("行動可能判定　開始！！")
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        for eachStatusChange in battleField.battleFieldPokemonArray[turnNo].statusChange
            
            
        {
            // メロメロ判定
            if eachStatusChange == StatusChange.meromero
            {
                let rand = arc4random_uniform(2)
                if rand < 1
                {
                    // battleField.battleFieldPokemonArray[turnNo].cantMove = true
                    //print("メロメロだ")
                    
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nあいてに メロメロだ！")
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                    return true
                }
            }
            
            // こんらん判定
            if eachStatusChange == .confuse(3)
            {
                let rand = arc4random_uniform(2)
                
                if rand < 1 {
                    // こんらんをスタックから解除する処理
                    //print("こんらんが　とけた！")
                    
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)の\nこんらんが とけた！")
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                    
                }
                else
                {
                    // battleField.battleFieldPokemonArray[turnNo].cantMove = true
                    
                    // 「わけも わからず 自分を こうげき」は端折っている。すまん
                    
                    //print("こんらんしている")
                    
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nまだ こんらん している！")
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                    return true
                }
            }
            
            // ひるみ
            if eachStatusChange == .flinch {
                //print("ひるんで うごけない！")
                
                // エンキュー
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nひるんで うごけない")
                } else {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name) can't move by its flinch.")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
                return true
            }

        }
        
        
        
        //まひ判定(これを、↑のステータス変化ループの中に書いてたせいで見事にはまった。こうやって外に出せ、外に。)
        if battleField.battleFieldPokemonArray[turnNo].badStatus == .palalyze
            
        {
            let rand = arc4random_uniform(4)
            
            if rand < 1
            {
                // battleField.battleFieldPokemonArray[turnNo].cantMove = true
                //print("まひして うごけない")
                
                // エンキュー
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nからだが しびれて うごけない")
                } else {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name) can't move by its paralysis.")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
                return true
            }
        }
        
        
        return false
    }
    
    
    
    // 2-1: 2-1-A で算出したダメージをもとにHPの増減
    func giveDamage(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        //print("いま、\(turnNo)のターンだよ、間違いないね。")
     
        //let damage = calculateDamage(moveNo: moveNo)
        
        let damage = CalculateDamage.calcurateDamage(whoIsTurn: whoIsTurn, moveNo: moveNo, attacker: battleField.battleFieldPokemonArray[turnNo], deffenser: battleField.battleFieldPokemonArray[turnNo.hantenInt])
        
        // すてみタックル・フレアドライブなど、反動ダメージ用に、tmpDamageにも与ダメージを格納しておく
        tmpDamage = damage
        
        
        //print("見ろ！！ 攻撃対象は \(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) だぞ！！")
        
        battleField.battleFieldPokemonArray[turnNo.hantenInt].HP -= damage
        
        
        // いままで、こうしていたのを、ビュージェネレーターに渡すには・・・・
        //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)に \(damage)の ダメージ！")
        
//        // エンキュー
//        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)に \(damage)の ダメージ！")
//        
//        // タイプライター風出力
//        myBVC.outputBattleMessageLikeTypeWriter()
        
        
//        var soundId: SystemSoundID = 0
//        
//        if let soundUrl = Bundle.main.url(forResource: "attack",withExtension: "mp3") {
//            
//            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
//            
//            AudioServicesPlaySystemSoundWithCompletion(soundId, { () -> Void in
//                //
//            })
//        }
      
        
        // ダメージ・アニメーション
        myBVC.HPchangeAnimationGenerator(tmp_myPokeHP: &tmp_myPokemonHP, tmp_foePokeHP: &tmp_foePokemonHP, damage: tmpDamage, whichTurn: whoIsTurn)
        
        judge.storeValueToTmpVar()

        
        
        
        
        // ここで 11/11 20:34 急遽 typewriter入れる仕組みにした
        // idxエラーおきないか？やばかったら消す
        // いまんとこ問題はおきていないが、相手が死亡時、若干もたつくというか、テンポが悪くなった...
        myBVC.outputBattleMessageLikeTypeWriter()
        
        
        
        
        
        
        
        
        // !!!: わりこみ処理(主にみちづれを意識して)
        // ここに書くのは、どうも筋が悪い気がする。
        // 常によい設計を探し、ここの記述を変えることも厭うな。
        interuptionProcessWhenDamageCalculationOccured(moveNo: moveNo)
        
        
        
        for x in 0...1 {
            
            let isEnemy: String
            
            if lang == true {
                
                if x == 0 {
                    isEnemy = ""
                } else {
                    isEnemy = "てきの "
                }
                
            } else {
                
                if x == 0 {
                    isEnemy = ""
                } else {
                    isEnemy = "The opposing "
                }
            }
            
            
            
            if battleField.battleFieldPokemonArray[x].HP <= 0 {
                
                //print("\(isEnemy)\(battleField.battleFieldPokemonArray[x].name)は たおれた！！！")
                
                if lang == true {
                
                    myBVC.enqueue(reveivedStr: "\(isEnemy)\(battleField.battleFieldPokemonArray[x].name)は たおれた!!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(isEnemy)\(battleField.battleFieldPokemonArray[x].name) was fainted!!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
            }
        }
        
        // 炎の攻撃技は、相手の氷を溶かす
        if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].type == .fire && battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].category != .status {
            
            if battleField.battleFieldPokemonArray[turnNo].badStatus == .ice {
               battleField.battleFieldPokemonArray[turnNo].badStatus = .null
            }
            
        }
        
        
        
        
        isDead()
    }
    
    
    // 2-2: HP回復
    func healHP() {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        // 回復量は最大HPの半分
        let healHP = battleField.battleFieldPokemonArray[turnNo].MAXHP / 2
        
        
        if battleField.battleFieldPokemonArray[turnNo].HP + healHP > battleField.battleFieldPokemonArray[turnNo].MAXHP {
            let currentHP = battleField.battleFieldPokemonArray[turnNo].HP
            battleField.battleFieldPokemonArray[turnNo].HP = battleField.battleFieldPokemonArray[turnNo].MAXHP
            
            if battleField.battleFieldPokemonArray[turnNo].MAXHP == battleField.battleFieldPokemonArray[turnNo].MAXHP {
                
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)の HPは\nすでに まんたんだ！")
                
                myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)の HPは\nすでに まんたんだ！")
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
            } else {
                
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)の HPが\n\(battleField.battleFieldPokemonArray[turnNo].MAXHP - currentHP) かいふくした！")
                
                myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)の HPが\n\(battleField.battleFieldPokemonArray[turnNo].MAXHP - currentHP) かいふくした！")
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
            }
            
            
        } else {
            battleField.battleFieldPokemonArray[turnNo].HP += healHP
            
            //print("\(battleField.battleFieldPokemonArray[turnNo].name)の HPが\n\(healHP) かいふくした！")
            
            myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)の HPが\n\(healHP) かいふくした！) かいふくした！")
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
        }
        
        

        
    }
    
    // 2-3-1: 相手にまひを付加
    func givePalalyze(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let rand = Int(arc4random_uniform(100))
        let percentageOfAddEffect = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectPer
        
        // でんじはの場合は、100%の確率で true になる
        if rand < percentageOfAddEffect {
            
            //print("追加効果発動！これぞジャンボジャンボあたりくじ！")
            
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].type1 == .ground || battleField.battleFieldPokemonArray[turnNo.hantenInt].type2 == .ground {
                //print("相手は じめんタイプなので まひ発生判定は 発生しません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

//                  // エンキュー
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "相手は じめんタイプなので\nまひ じょうたいに ならない！")
                    } else {
                        myBVC.enqueue(reveivedStr: "The enemy doesn't paralyze because it's ground type!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                }
                
                return
            }
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].type1 == .electric || battleField.battleFieldPokemonArray[turnNo.hantenInt].type2 == .electric {
                //print("相手は でんきタイプなので まひ じょうたいに なりません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                        myBVC.enqueue(reveivedStr: "相手は でんきタイプなので\nまひ じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "The enemy doesn't paralyze because it's electric type!")
                    }
                
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
//                    // これがないと　まひが反映されない。
//                    judge.storeValueToTmpVar()
                    
                }

                return
            }
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .null {
                
                battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus = .palalyze
                
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nまひして わざが でにくくなった！")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                
                // エンキュー
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nまひして わざが でにくくなった!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) got paralyzed!")
                    }
                    
                myBVC.outputBattleMessageLikeTypeWriter()
                
                // これがないと　まひが反映されない。
                judge.storeValueToTmpVar()
                
                }
                
//                myBVC.renewBIW(howToActivate: .currentBF) // なんか、なくても　大丈夫だね
                
//                myBVC.outputBattleInfoWindow()

                
                // !!!: わりこみ処理(主にシンクロを意識して)
                // ここに書くのは、どうも筋が悪い気がする。
                // 常によい設計を探し、ここの記述を変えることも厭うな。
                interuptionProcessWhenBadStatusSticked()
                
                
            } else if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .palalyze {
                
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに まひしている")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに まひしている")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) is already paralyzed.")
                    }
                
                    myBVC.outputBattleMessageLikeTypeWriter()
                }
                
                
                
            } else {
                //print("すでに 状態異常なので うわがき されません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は すでに 状態異常なので\nまひ じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) doesn't paralyze because it already has Bad Status.")
                    }
                    myBVC.outputBattleMessageLikeTypeWriter()
                }
            }
        }
    }
    
    
    // 2-3-2: 相手にやけどを付加
    func giveBurn(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let rand = Int(arc4random_uniform(100))
        let percentageOfAddEffect = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectPer
        
//        print("ランダム係数: \(rand)！")
        
        // おにびの場合は、100%の確率で true になる
        if rand < percentageOfAddEffect {
            
            //print("追加効果発動！これぞジャンボジャンボあたりくじ！")
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].type1 == .fire || battleField.battleFieldPokemonArray[turnNo.hantenInt].type2 == .fire {
                //print("相手は ほのおタイプなので やけど じょうたいに なりません")

                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "相手は ほのおタイプなので\nやけど じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "The enemy doesn't burn because it's fire type!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                }
                return
            }
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .null {
                
                battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus = .burned
                
                // !!!: わりこみ処理(主にシンクロを意識して)
                // ここに書くのは、どうも筋が悪い気がする。
                // 常によい設計を探し、ここの記述を変えることも厭うな。
                interuptionProcessWhenBadStatusSticked()
                
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nやけどを おった！")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                
                    // エンキュー
                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nやけどを おった!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) got burned!")
                    }
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    // これがないと　やけどが反映されない。
                    judge.storeValueToTmpVar()
                }
            
                
                
            } else if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .burned {
                
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに やけどしている")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに やけどしている")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) is already burned.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                
                }
                
            } else {
                
                //print("すでに 状態異常なので うわがき されません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は すでに 状態異常なので\nやけど じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) doesn't burn because it already has Bad Status.")
                    }
                    myBVC.outputBattleMessageLikeTypeWriter()

                }
            }
        }
    }
    
    
    // 2-3-3: 相手にこおりを付加
    func giveIce(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let rand = Int(arc4random_uniform(100))
        let percentageOfAddEffect = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectPer
        
        //        print("ランダム係数: \(rand)！")
        
        // れいとうビームの場合は、10%の確率で true になる
        if rand < percentageOfAddEffect {
            
            //print("追加効果発動！これぞジャンボジャンボあたりくじ！")
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].type1 == .ice || battleField.battleFieldPokemonArray[turnNo.hantenInt].type2 == .ice {
                
                //print("相手は こおりタイプなので こおり じょうたいに なりません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "相手は こおりタイプなので\nこおり じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "The enemy doesn't burn because it's ice type!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                }
                
                return
            }
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .null {
                
                battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus = .ice
                
                // !!!: わりこみ処理(主にシンクロを意識して)
                // ここに書くのは、どうも筋が悪い気がする。
                // 常によい設計を探し、ここの記述を変えることも厭うな。
                interuptionProcessWhenBadStatusSticked()
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nこおりづけに なった！")
                
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nこおりづけに なった!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) got freezed!")
                    }
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                }

            } else if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .ice {
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
//
//                    print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに こおっている")
//                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに こおっている")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) is already freezed.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
//                    
                }
                
                
            } else {

                //print("すでに 状態異常なので うわがき されません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は すでに 状態異常なので\nこおり じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) doesn't freeze because it already has Bad Status.")
                    }
                        
                    myBVC.outputBattleMessageLikeTypeWriter()
                }
            }
        }
    }
    
    
    // 2-3-4: 相手にねむりを付加
    func giveSleep(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let rand = Int(arc4random_uniform(100))
        let percentageOfAddEffect = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectPer
        
        
        //
        if rand < percentageOfAddEffect {
            
            //print("追加効果発動！これぞジャンボジャンボあたりくじ！")
            
            if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Sleep Powder" && battleField.battleFieldPokemonArray[turnNo.hantenInt].type1 == .grass || battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Sleep Powder" && battleField.battleFieldPokemonArray[turnNo.hantenInt].type2 == .grass {
                
                //print("相手は くさタイプなので こなの わざを うけませんし、とうぜん ここで ねむりにも なりません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                        myBVC.enqueue(reveivedStr: "相手は くさタイプなので\nこなの わざを うけない")
                    } else {
                        myBVC.enqueue(reveivedStr: "Doesn't be affected by powder because it's grass type.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                }
                
                return
            }
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .null {
                
                battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus = .sleep
                
                // !!!: わりこみ処理(主にシンクロを意識して)
                // ここに書くのは、どうも筋が悪い気がする。
                // 常によい設計を探し、ここの記述を変えることも厭うな。
                interuptionProcessWhenBadStatusSticked()
                
                
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nねむってしまった！")
                
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nねむってしまった!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) got slept!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    // これがないと　ねむりが反映されない。
                    judge.storeValueToTmpVar()

                }

            } else if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .sleep {
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに ねむっている")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに ねむっている")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) is already sleeping.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
               }
                
            } else {
                //print("すでに 状態異常なので うわがき されません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は すでに 状態異常なので\nねむり じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) doesn't sleep because it already has Bad Status.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                }
            }
        }
    }
    
    // 2-3-5: 相手にどくを付加
    func givePoison(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let rand = Int(arc4random_uniform(100))
        let percentageOfAddEffect = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectPer
        
        
        // ヘドロばくだん なら、30%の確率で発動
        if rand < percentageOfAddEffect {
            
            //print("追加効果発動！これぞジャンボジャンボあたりくじ！")
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].type1 == .poison || battleField.battleFieldPokemonArray[turnNo.hantenInt].type2 == .poison || battleField.battleFieldPokemonArray[turnNo.hantenInt].type1 == .steel || battleField.battleFieldPokemonArray[turnNo.hantenInt].type2 == .steel {
                
                //print("相手は どく か はがねタイプなので どく じょうたいに なりません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)の タイプは どくをも はじく!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)'s type protected toxic!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                }
                
                return
            }
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .null {
                
                
                if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "Toxic" {
                    battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus = .toxic
                    
                    //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nもうどくをあびた！")
                    
                    
                    if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                        if lang == true {
                            myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nもうどくをあびた!")
                        } else {
                            myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) got toxic!")
                        }
                        
                        myBVC.outputBattleMessageLikeTypeWriter()
                        
                        // これがないと　どくが反映されない。
                        judge.storeValueToTmpVar()
                        
                    }
                    
                    
                } else {
                    battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus = .poison
                    //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nどくを あびた！")
                    
                    if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                        
                        // エンキュー
                        if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nどくを あびた!")
                        } else {
                            myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) got poison!")
                        }
                        
                        myBVC.outputBattleMessageLikeTypeWriter()
                        
                        // これがないと　どくが反映されない。
                        judge.storeValueToTmpVar()
                    }
                }
                
                
                // !!!: わりこみ処理(主にシンクロを意識して)
                // ここに書くのは、どうも筋が悪い気がする。
                // 常によい設計を探し、ここの記述を変えることも厭うな。
                interuptionProcessWhenBadStatusSticked()
                
                
            } else if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .toxic || battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .poison {
                
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに どくを うけている")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに どくを うけている")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) already has poison.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    
                }
                
                
                
                
            } else {
                //print("すでに 状態異常なので うわがき されません")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は すでに 状態異常なので\nどく じょうたいに ならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) doesn't get poison because it already has Bad Status.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                }                
            }
        }
    }
    
    
    // ああ、またグローバル変数をつくってしまった。。。。。typewriteされるかどうかに使われる、「このわざのバフの対象はどちらか」
    // true = 自分 / false = 相手
    var addTargetTo: Bool?
    
    
    var moveName: String?
    
    
    // 2-4 バフ・デバフ
    func buffdebuff(moveNo: Int) {
                
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        let rand = Int(arc4random_uniform(100))
        
        // わざごとの追加効果発生確率に応じた確率判定
        if rand < battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectPer {
            
            //print("追加効果発動！バフデバフが あがった！")
            
            // 発動したわざの対象が「自分」の場合 (Ex. つめとぎ、つるぎのまい、こうそくいどう など)
            if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].addEffectTo == true {
            
                addTargetTo = true
                moveName = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name

                
                battleField.battleFieldPokemonArray[turnNo].buffDebuff.statsLVArray = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].buffLevel
                
                addTargetTo = nil
                moveName = nil
                
            // 対象が「相手」の場合(ex. なきごえ、しっぽをふる、など)
            } else {
                
                addTargetTo = false

                battleField.battleFieldPokemonArray[turnNo.hantenInt].buffDebuff.statsLVArray = battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].buffLevel
                
                addTargetTo = nil
                moveName = nil

            }
            
        } // end of if percentage
        
    } // end of buffdebuff()
    
    

    // 2-5 自分にも反動ダメージ(すてみタックル, フレアドライブ, など <とびひざげり>は処理が異なるので別に記述)
    func recoil(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        // とびひざげり の場合の特別な分岐
        if battleField.battleFieldPokemonArray[turnNo].moveArray[moveNo-1].name == "High Jump Kick" {
            
            if couldHitMove == false {

                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は いきおいあまって\nじめんに ぶつかった！")
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は \(battleField.battleFieldPokemonArray[turnNo].MAXHP)の ダメージを うけた！")
                
                if lang == true {
                myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は いきおいあまって\nじめんに ぶつかった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name) kept going and crashed!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                // ここは意味ない。ただし、↓の store〜は書かないとおかしい。と、このように、書く位置が重要なのだ。
                // というか、最初から enqueueの前に store かくべきだった。。。痛恨のミス。
                
//                judge.storeValueToTmpVar()
                
                
                
                tmpDamage = battleField.battleFieldPokemonArray[turnNo].MAXHP / 2
                
                
                battleField.battleFieldPokemonArray[turnNo].HP -= battleField.battleFieldPokemonArray[turnNo].MAXHP / 2
                
                // 関数名に注意。「ForItself」のほうを使え
                myBVC.HPchangeAnimeForItself(tmp_myPokeHP: &tmp_myPokemonHP, tmp_foePokeHP: &tmp_foePokemonHP, damage: tmpDamage, whichTurn: whoIsTurn)
                
                
                
                judge.storeValueToTmpVar()
                
                
                
            if battleField.battleFieldPokemonArray[turnNo].HP <= 0 {
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は たおれた！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は たおれた!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name) was fainted!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
                
            }
                
            isDead()
            
            return
                
            }
            
        } else {
            
            // この攻撃で相手を倒した場合の、ダメージ量の調整
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP <= 0 {
                
                tmpDamage = battleField.battleFieldPokemonArray[turnNo.hantenInt].tmpHP_toRestrictRecoilDamage
                
                // ここで、対象ポケモンの食い止めHPをリセットしておくのが吉か。
                battleField.battleFieldPokemonArray[turnNo.hantenInt].tmpHP_toRestrictRecoilDamage = 0
            }
            
            battleField.battleFieldPokemonArray[turnNo].HP -= tmpDamage / 3
            
            
            //print("\(battleField.battleFieldPokemonArray[turnNo].name) は はんどうで \(tmpDamage / 3) ダメージを うけた！")
            
            // 関数名に注意。「ForItself」のほうを使え
            myBVC.HPchangeAnimeForItself(tmp_myPokeHP: &tmp_myPokemonHP, tmp_foePokeHP: &tmp_foePokemonHP, damage: tmpDamage, whichTurn: whoIsTurn)
            
            
            if lang == true {
            myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nこうげきの はんどうを うけた!")
            } else {
                myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)'s hit with recoil!")
            }
            
            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            
            if battleField.battleFieldPokemonArray[turnNo].HP <= 0 {
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は たおれた!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name) was fainted!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                
                judge.storeValueToTmpVar()
                
                isDead()
                
            }
            
        }
        
        isDead()
    }
    
    // 2-6 みちづれ
    func destinyBond() {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
//        print("こっちのターンだよな！？ \(turnNo)")
//        
//        print("現在の格納値: \(battleField.battleFieldPokemonArray[turnNo].statusChange)")
//        
//        print("結果: \(battleField.battleFieldPokemonArray[turnNo].statusChange.index(of: TypeWriterOutput.StatusChange.destinyBond(1)))")
        
        if battleField.battleFieldPokemonArray[turnNo].statusChange.index(of: spb.StatusChange.destinyBond(1)) == nil {
            //print("みちづれ状態 追加だよ！")
            battleField.battleFieldPokemonArray[turnNo].statusChange.append(.destinyBond(0))
        
        } else {
            
            
            // 要するに、statusChange[]内に格納される destinyBond は、絶対に1個だけにとどめたいのだ。
            //print("みちづれは もう 格納されてるから 1個で じゅうぶん")
            //print("とかいいつつ、こっそりカウントを設定し直す。なんともこすい。")
            
            // MARK: ここ　超あやしい！
            let idx = battleField.battleFieldPokemonArray[turnNo].statusChange.index(of: spb.StatusChange.destinyBond(1))
            
            battleField.battleFieldPokemonArray[turnNo].statusChange[idx!] = StatusChange.destinyBond(0)
            
        }
        
        
        if lang == true {
        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nあいてを みちづれに しようとしている！")
        } else {
              myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name) is trying to invite to a netherworld!")
        }
        
        myBVC.outputBattleMessageLikeTypeWriter()
        
        judge.storeValueToTmpVar()
        
    }
    
    // 2.7 あくび
    func yawn() {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        //print("相手のステータス変化配列： \(battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange)")
        //print("その個数： \(battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange.count)")

        
        for var eachStatusChange in battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange {

            switch eachStatusChange {

                case .yawn(let count)
                    
                    where count > 0:
                        // 要するに、statusChange[]内に格納される yawn は、絶対に1個だけにとどめたいのだ。
                        //print("あくびは もう 格納されてるから 1個で じゅうぶん")
                        //print("とかいいつつ、こっそりカウントを設定し直す。なんともこすい。")
                        eachStatusChange = eachStatusChange.reset()
                
                default:
                    print("")
            }
        }
        
        
        // こんな奇妙な書き方しても、おかしなことにひっかかる。困った。原因不明。
        // この書き方でも、「とにかく yawn があれば (その値は気にしない)」　条件を満たす
        if battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange.index(of: spb.StatusChange.yawn(99999)) == nil {
            
            //print("あくび状態 追加だよ！")
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].badStatus == .null {
                battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange.append(.yawn(0))
                //print("\(battleField.battleFieldPokemonArray[turnNo].name)は\nあいての ねむけを さそった！")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name)は\nあいての ねむけを さそった!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo].name) brought out the enemy's drawsiness!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                }
                
                
            } else {
                //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに 状態異常なので ねむくならない！")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {

                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nすでに 状態異常なので ねむくならない")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) doesn't get sleepy because it already has Bad Status.")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                }
            }
            
        }
    } // func()
    
    
    // 2-8 ねこだまし などで ひるませる
    func makeFlinch(moveNo: Int) {
        
        // 今、自分のターンなら 0、 相手のターンなら 1
        let turnNo = whoIsTurn ? 0 : 1
        
        // 唐突に リーダブルコードを 参考にしました笑
        let enemyAbility = battleField.battleFieldPokemonArray[turnNo.hantenInt].ability
        
        if enemyAbility == .innerfocus {
            
            //print("せいしんりょくで ひるまない！")
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
            
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nせいしんりょくで ひるまない！")
                } else {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) doesn't get flinch for its Inner Focus!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
            
            }
            
            judge.storeValueToTmpVar()
    
            return
        }
        
        // ひるみは、先制しないと発動しない
        else if actOrder == false {
//            print("ひるみは 後攻だと 発生しない！")
            return
        }
        
        
        for var eachStatusChange in battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange {
            
            switch eachStatusChange {
                
            case .flinch:
                
                // 要するに、statusChange[]内に格納される flinch は、絶対に1個だけにとどめたいのだ。
                //print("ひるみ もう 格納されてるから 1個で じゅうぶん")
                //print("とかいいつつ、こっそりカウントを設定し直す。なんともこすい。")
                eachStatusChange = eachStatusChange.reset()
                
            default:
                print("")
            }
        }
        
        
        if battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange.index(of: spb.StatusChange.flinch) == nil {
            
            
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
            
            battleField.battleFieldPokemonArray[turnNo.hantenInt].statusChange.append(.flinch)
            //print("\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nひるんでしまった！")
            
                if lang == true {
            myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は\nひるんでしまった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name) got flinch!")
                }
            
            //print("ひるみ状態 追加だよ！")

            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            }
            
            
            
            
            
            if battleField.battleFieldPokemonArray[turnNo.hantenInt].ability == .steadfast {
                
                //print("あいては ふくつのこころで すばやさが あがった！")
                
                if battleField.battleFieldPokemonArray[turnNo.hantenInt].HP > 0 {
                
                    battleField.battleFieldPokemonArray[turnNo.hantenInt].buffDebuff.statsLVArray = [0,0,0,0,1]
                    
                    if lang == true {
                    myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)は ふくつのこころで\nすばやさが あがった！")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[turnNo.hantenInt].name)'s SPEED rose by its Steadfast!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                }
                
                //print("バフLv: \(battleField.battleFieldPokemonArray[turnNo.hantenInt].buffDebuff)")
            }
        }
    } // makeFlinch()
    
    
    
    
    // 3. 死亡処理
    func isDead() {
        
        // どちらかのトレーナーのパーティ3体が全員死亡しているなら、その時点でバトル終了
        func judgeBattleEnd() {
            judgeIbeatFoe()
            judgeIamBeaten()
        }
        
        judgeBattleEnd()
        
    }
    
    // 3体倒され、勝負に負けたか？
    func judgeIamBeaten() {
        if battleField.myParty[0].HP <= 0 && battleField.myParty[1].HP <= 0 && battleField.myParty[2].HP <= 0 {
            
            
            
            // 連勝カウントを0に
            let userDefaults = UserDefaults.standard
            
            userDefaults.set(0, forKey: "winCount")
            
            userDefaults.synchronize()
            
            
            
            judge.storeValueToTmpVar()
            
            myBVC.outputBattleMessageWhenInputStandBy()
            
            ViewManipulation.resetOutputColor()
            
            print("\u{1b}[1;5m", terminator: "") // 点滅

            print("You lost...")

            ViewManipulation.resetOutputColor()
            
            print("")
                        
            exit(1)
        }
    }
    
    // 相手を3体倒し、勝負に勝ったか？
    func judgeIbeatFoe() {
        if battleField.foeParty[0].HP <= 0 && battleField.foeParty[1].HP <= 0 && battleField.foeParty[2].HP <= 0 {
            
            
            // 連勝カウント +1
            let userDefaults = UserDefaults.standard
            
            // なんでここ letで大丈夫なんだ...謎...
            let winCount = userDefaults.integer(forKey: "winCount")
            
            userDefaults.set(winCount + 1, forKey: "winCount")
            
            userDefaults.synchronize()
            
            
            judge.storeValueToTmpVar()
            
            myBVC.outputBattleMessageWhenInputStandBy()
            
            // ここに書いても、みちづれで赤のときは。赤のまま。なぜだ
//            ViewManipulation.resetOutputColor()
            
            if lang == true {
                myBVC.enqueue(reveivedStr: "masaとの\nしょうぶに かった!!")
            } else {
                myBVC.enqueue(reveivedStr: "You defeated masa!!")
            }
            
            myBVC.enqueue(reveivedStr: "masa「I really appreciate your playing!!\nI hope you enjoyed a lot!!」")
            
            // ここに書いても、みちづれで赤のときは。赤のまま。なぜだ
            
            ViewManipulation.resetOutputColor()

            myBVC.outputBattleMessageLikeTypeWriter()
            
            judge.storeValueToTmpVar()
            
            print("\u{1b}[1;5m", terminator: "") // 点滅

            print("")
            
            print("You won!!!")
            
            ViewManipulation.resetOutputColor()
            
            print("")

            exit(1)
        }
    }
    
    
    // 97. 各ポケモン(味方 / 敵)の行動終了ごとに、ステータス変化のカウントが増減する
    
    func statusChangeCountPlus() {
        
         // 今、自分のターンなら 0、 相手のターンなら 1
         // let turnNo = whoIsTurn ? 0 : 1
        
        
        // 1ループ目で 自分のポケモン・場の処理、2ループ目で 相手のポケモン・場の処理。
        for turnNo in 0...1 {
            
//            let turn = turnNo == 0 ? "自分のポケモン" : "敵のポケモン"
            //print("カウンタ増減！！ \(turn)")
            
            var newStatusAry: [StatusChange] = []
            
            //print("古いステータス変化配列: \(battleField.battleFieldPokemonArray[turnNo].statusChange)")
            
            for eachStatusChange in battleField.battleFieldPokemonArray[turnNo].statusChange {
                
                switch eachStatusChange {
                    
                case .destinyBond(let count):
                    
                    //print("みちづれ 来てますね")
                    
                    // カウンタの増加
                    newStatusAry.append(.destinyBond(count + 1))
                    
                case .yawn(let count):
                    
                    //print("あくび 来てますね")
                    
                    // カウンタの増加
                    newStatusAry.append(.yawn(count + 1)) //
//                    print("いまの 新配列は \(newStatusAry) です")
                    
                case .flinch:
                    
                    newStatusAry.append(.flinch)
                    
                    
                default:
                    print("")
                    
                } // switch
                
            } // for
        
            battleField.battleFieldPokemonArray[turnNo].statusChange = newStatusAry
            
            //print("新しいステータス変化配列: \(battleField.battleFieldPokemonArray[turnNo].statusChange)")
        } // 外側の for
    } // func
    

    // 98. 毎ターン終了時の処理
    func turnEnd() {
        turnEndProcessImplement()
    } // turnEnd
    
    
    func turnEndProcessImplement() {
        
        //print("ターン終了時の処理に 突入しました！")
        
        
        // STEP1: 状態異常に応じた処理
        
        // 1ループ目で 自分のポケモン・場の処理、2ループ目で 相手のポケモン・場の処理。
        for whichProcess in 0...1 {
            
            // A. まずは、自分のポケモン・場から判定
            let receivedEffectProcess = battleField.battleFieldPokemonArray[whichProcess].manifestMyselfEffect()
            
            // print("受け取った効果は \(receivedEffectProcess)です")
            
            // 受け取った効果の実効を発動
            switch receivedEffectProcess {
                
            case .poisonDamage:
                
                if battleField.battleFieldPokemonArray[whichProcess].HP > 0 {

                
                    let poisonDamage = battleField.battleFieldPokemonArray[whichProcess].MAXHP / 8
                    
                    battleField.battleFieldPokemonArray[whichProcess].HP -= poisonDamage
                    //print("\(battleField.battleFieldPokemonArray[whichProcess].name)は\nどくの ダメージ \(poisonDamage) を うけている！")
                    
                    let judgeEnemyTurn: String
                    
                    if lang == true {
                        
                        judgeEnemyTurn = whichProcess.outputBool ? "" : "てきの "
                        
                    } else {
                        
                        judgeEnemyTurn = whichProcess.outputBool ? "" : "The opposite "
                        
                    }
                    
                    
                    
                    // エンキュー
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(judgeEnemyTurn)\(battleField.battleFieldPokemonArray[whichProcess].name)は\nどくの ダメージを うけている!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(judgeEnemyTurn)\(battleField.battleFieldPokemonArray[whichProcess].name) got damage\nby its poison!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()

                    myBVC.HPchangeAnimeForItself(tmp_myPokeHP: &tmp_myPokemonHP, tmp_foePokeHP: &tmp_foePokemonHP, damage: poisonDamage, whichTurn: whichProcess.outputBool)
                    
                    judge.storeValueToTmpVar()
                    
                }
                
                
                if battleField.battleFieldPokemonArray[whichProcess].HP <= 0 {
                    
                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[whichProcess].name)は たおれた!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[whichProcess].name) was fainted!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                    
                }
                
                
                
                isDead()
                
            case .burnedDamage:
                
                if battleField.battleFieldPokemonArray[whichProcess].HP > 0 {
                
                
                    let burnedDamage = battleField.battleFieldPokemonArray[whichProcess].MAXHP / 8
                    
                    battleField.battleFieldPokemonArray[whichProcess].HP -= burnedDamage
                    
                    
                    //print("\(battleField.battleFieldPokemonArray[whichProcess].name)は\nやけどの ダメージ \(burnedDamage) を うけている！")
                    
//                    let judgeEnemyTurn: String = whichProcess.outputBool ? "" : "てきの "
                    
                    let judgeEnemyTurn: String

                    if lang == true {
                        
                        judgeEnemyTurn = whichProcess.outputBool ? "" : "てきの "
                        
                    } else {
                        
                        judgeEnemyTurn = whichProcess.outputBool ? "" : "The opposite "
                        
                    }
                    
                    
                    
                    // エンキュー
                    
                    if lang == true {
                    
                        myBVC.enqueue(reveivedStr: "\(judgeEnemyTurn)\(battleField.battleFieldPokemonArray[whichProcess].name)は\nやけどの ダメージを うけている！")
                        
                    } else {
                        
                        myBVC.enqueue(reveivedStr: "\(judgeEnemyTurn)\(battleField.battleFieldPokemonArray[whichProcess].name) get damage\nby its burn!")
                        
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                        
                    myBVC.HPchangeAnimeForItself(tmp_myPokeHP: &tmp_myPokemonHP, tmp_foePokeHP: &tmp_foePokemonHP, damage: burnedDamage, whichTurn: whichProcess.outputBool)
                        
                    judge.storeValueToTmpVar()

                }
                
                
                if battleField.battleFieldPokemonArray[whichProcess].HP <= 0 {

                    if lang == true {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[whichProcess].name)は たおれた!")
                    } else {
                        myBVC.enqueue(reveivedStr: "\(battleField.battleFieldPokemonArray[whichProcess].name) was fainted!")
                    }
                    
                    myBVC.outputBattleMessageLikeTypeWriter()
                    
                    judge.storeValueToTmpVar()
                    
                    
                }
                
                isDead()
                
            default:
                print("")
                
            } // switch
        } // for
        
        
        // !!!: わりこみ処理(主に あくび を意識して)
        // ここに書くのは、どうも筋が悪い気がする。
        // 常によい設計を探し、ここの記述を変えることも厭うな。
        interuptionProcessWhenTurnEnd()

        
        // STEP2: ステータス変化を解除
        statusChangeReset()
        
    } // turnEndProcessImplement
    
    
    // 98 STEP2: 現在の各ステータス変化をもとに、ステータス変化の消滅をさせる
    
    func statusChangeReset() {
        
        // 1ループめで「自分のポケモン」、2ループめで「敵のポケモン」の判定
        for x in 0...1 {
            
//            let turn = x == 0 ? "自分のポケモン" : "敵のポケモン"
            //print("カウンタ増減！！ \(turn)")
            
            var newStatusAry: [StatusChange] = []
            
            //print("古いステータス変化配列: \(battleField.battleFieldPokemonArray[x].statusChange)")
            
            for eachStatusChange in battleField.battleFieldPokemonArray[x].statusChange {
                
                switch eachStatusChange {
                    
                    case .destinyBond(let count):
                        
                        //print("みちづれ 来てますね")
                        
                        //print("かうんと: \(count)")
                        
                        // 処理1: 2以上なら、みちづれ状態の除去
                        if count >= 2 {
                            //print("みちづれ状態を解除しました")
                        }
                            
                        else if count == 1 { // 1なら(0は 理論上ないはず)

                        newStatusAry.append(.destinyBond(count)) // 必ず 1 になるはず。
                        //print("いまの 新配列は \(newStatusAry) です")
                        
                        } else {
                            //print("これみえてると　やばい")
                        }
                        
                    case .yawn(let count):
                        
                        //print("あくび 来てますね")
                        
                        // 処理1: ステータス変化の除去
                        if count >= 3 {
                            //print("あくび状態を解除しました")
                        }
                        else {
        
                            // 処理2: カウンタの増加
                            newStatusAry.append(.yawn(count))
                            //print("いまの 新配列は \(newStatusAry) です")
                        }
                        
                    default:
                        print("")
                    } // switch
            } // eachStatusのfor
            
            battleField.battleFieldPokemonArray[x].statusChange = newStatusAry
            
            //print("\(turn)新しいステータス変化配列: \(battleField.battleFieldPokemonArray[x].statusChange)")
        } // 味方・敵の for
    } // func
    
    
    // 99. 死亡による強制ポケモンチェンジ。新しいポケモンが場にセットされる
    func forcedPokemonChange() {
        
        // 味方ポケモンが死亡したなら
        while battleField.myBattlePokemon.HP <= 0 {
            //print("味方ポケモン 死亡！ 強制ポケモンチェンジ！")
            pokemonChange()
            appearField()
        }
        
        // 敵ポケモンが死亡したなら
        while battleField.foeBattlePokemon.HP <= 0 {
            //print("敵ポケモン 死亡！ 強制ポケモンチェンジ！")
            foePokemonChange()
            appearField()
        }
        
        
    }  // 99. foecedPokemonChange
    
    
    
    // 「ひるみ」の先行後攻判定のためだけに作られた、悲しき変数。
    // true : 自分が先行、 false : 相手が先行。
    // この変数は、「ひるみの処理」の「先行後攻判定」スコープを通ったとき、その最後にnilに再設定される。
    var actOrder: Bool? = nil
    
    
    
    // MARK: 行動順を決定する関数
    func judgeActionOrder(moveNo: Int, foeAction: Int) {
        
        
        enum OrderName {
            
            case myPokemonPriorityByMove  // パターン1: 先制わざでこちらが先制
            case foePokemonPriorityByMove // パターン2: 先制わざで敵が先制
            
            case myPokemonPriorityBySpeed // パターン3: こちらのすばやさが上
            case foePokemonPriorityBySpeed // パターン4: 相手のすばやさが上
            
            case random // パターン5 両者、優先度もすばやさも同じ
        } // enum
        
        
        // パターン1 or 3. 自分が先行
        func myPokemonPriority(moveNo: Int, foeAction: Int) {
            
            
            actOrder = true
            
            
            
            // A. まずは、自分の攻撃
            
            // 今は、自分のターン
            whoIsTurn = true
            
            // 1.5. 自分: わざ発動
            moveExecuteProcess(moveNo: moveNo)
            
            // 97. カウント増減
            statusChangeCountPlus()
            
            // B. 次に、相手の攻撃
            
            // 相手のターンになる。
            whoIsTurn = false
            
            //            let foeAction = Int(arc4random_uniform(4) + 1)
            
            //print("てきの こうどうは \(foeAction)が えらばれました")
            
            // 1.5. 相手: わざ発動
            moveExecuteProcess(moveNo: foeAction)
            
            // 97. カウント増減
            statusChangeCountPlus()
            
            // 98. 毎ターン終了時の処理
            turnEnd()
            
        } // パターン1 or 3
        
        // パターン2 or 4. 相手が先行
        func foePokemonPriority(moveNo: Int, foeAction: Int) {
            
            actOrder = false

            
            // A. まずは、相手の攻撃
            
            // 今は、相手のターン
            whoIsTurn = false
                        
            //print("てきの こうどうは \(foeAction)が えらばれました")
            
            // 1.5. わざ: わざ発動
            moveExecuteProcess(moveNo: foeAction)
            
            // 97. カウント増減
            statusChangeCountPlus()
            
            // B. 次に、自分の攻撃
            
            // 自分のターンになる。
            whoIsTurn = true
            
            // 1.5. 自分: わざ発動
            moveExecuteProcess(moveNo: moveNo)
            
            // 97. カウント増減
            statusChangeCountPlus()
            
            // 98. 毎ターン終了時の処理
            turnEnd()
            
        } // パターン2 or 4
        
        // パターン3. ランダム
        func random(moveNo: Int, foeAction: Int) {
            
            let rand = Int(arc4random_uniform(2))
            
            switch rand {
                case 0:
                    myPokemonPriority(moveNo: moveNo, foeAction: foeAction)
                case 1:
                    foePokemonPriority(moveNo: moveNo, foeAction: foeAction)
                default:
                    print("Irregular!")
            }
        } // パターン3
        
        
        func generateActionOrderNo(moveNo: Int, foeAction: Int) -> OrderName {
            
            var palalyzeDecreseMag_MyPokemon: Double {
                
                if battleField.myBattlePokemon.badStatus == .palalyze {
                    return 0.25
                }
                
                return 1
                
            }
            
            var palalyzeDecreseMag_FoePokemon: Double {
                
                if battleField.foeBattlePokemon.badStatus == .palalyze {
                    return 0.25
                }
                
                return 1
                
            }
            
            let myPokeSpd = Int(Double(battleField.myBattlePokemon.SPEED) * palalyzeDecreseMag_MyPokemon * battleField.myBattlePokemon.buffDebuff.mag_speed)
            let foePokeSpd = Int(Double(battleField.foeBattlePokemon.SPEED) * palalyzeDecreseMag_FoePokemon * battleField.foeBattlePokemon.buffDebuff.mag_speed)
            
            
            if battleField.myBattlePokemon.moveArray[moveNo-1].priority > battleField.foeBattlePokemon.moveArray[foeAction-1].priority {
                
                //print("こちらの優先度 : \(battleField.myBattlePokemon.moveArray[moveNo-1].priority) 相手の優先度 : \(battleField.foeBattlePokemon.moveArray[foeAction-1].priority)！ パターン1！")
                
                //print("相手の技: \(battleField.foeBattlePokemon.moveArray[foeAction-1].name)！")
                
                // パターン1
                return .myPokemonPriorityByMove
                
            } else if battleField.myBattlePokemon.moveArray[moveNo-1].priority < battleField.foeBattlePokemon.moveArray[foeAction-1].priority {
                
                //print("こちらの優先度 : \(battleField.myBattlePokemon.moveArray[moveNo-1].priority) 相手の優先度 : \(battleField.foeBattlePokemon.moveArray[foeAction-1].priority)！ パターン2！")
                
                // パターン2
                return .foePokemonPriorityByMove
                
            } else if myPokeSpd > foePokeSpd {
                
                //print("こちらの優先度 : \(battleField.myBattlePokemon.moveArray[moveNo-1].priority) 相手の優先度 : \(battleField.foeBattlePokemon.moveArray[foeAction-1].priority)！")
                //print("こちらの素早さ : \(myPokeSpd) 相手の素早さ : \(foePokeSpd)！ パターン3！")
                
                // パターン3
                return .myPokemonPriorityBySpeed
                
            } else if myPokeSpd < foePokeSpd {
                
                //print("こちらの優先度 : \(battleField.myBattlePokemon.moveArray[moveNo-1].priority) 相手の優先度 : \(battleField.foeBattlePokemon.moveArray[foeAction-1].priority)！")
                //print("こちらの素早さ : \(myPokeSpd) 相手の素早さ : \(foePokeSpd)！ パターン4！")
                
                // パターン4
                return .foePokemonPriorityBySpeed
                
            } else {
                //print("同じ素早さ！ パターン5！")
                
                // パターン5
                return .random
            }
            
        } // generateActionOrderNo()
        
        
        let orderName = generateActionOrderNo(moveNo: moveNo, foeAction: foeAction)
        
        switch orderName {
            
        case .myPokemonPriorityByMove, .myPokemonPriorityBySpeed:
            myPokemonPriority(moveNo: moveNo, foeAction: foeAction)
        case .foePokemonPriorityByMove, .foePokemonPriorityBySpeed:
            foePokemonPriority(moveNo: moveNo, foeAction: foeAction)
        case .random:
            random(moveNo: moveNo, foeAction: foeAction)
        }
        
    }  // judgeActionOrder

    
} // Judge

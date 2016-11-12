#!/usr/bin/swift
// #!/usr/bin/local swift

import Foundation

// ポケモンチェンジでキャンセルが押された
var quit = false


////////////////

// 本来、　この repository と controllerCHain は この位置だったが、 11/9 8:00　急遽　↓の位置に変更した
// やばかったら戻して

/////////////////

//let repository = MemoryRepository()

//// cc97042 以降で 追記。やばかったら戻す。
//let controllerChain = PokemonController(repo: repository, nextController: FieldConditionController(repo: repository, nextController: nil))



// これらのプロパティはどこからでも使える。うまく使え

////////////////
/// コンフィグ ///
////////////////


var isMusicPlayed = false

// バトルメッセージ スピード
var messageSpeed: String = "middle"

// バトルメッセージ・言語(false: 英語、 true: 日本語)
// たぶんこっちは、↓のuserdefault.boolで少なくとも必ずfalseが返るので、initしなくてもよいっぽい？
var lang: Bool


let userDefaults = UserDefaults.standard

if let spd = userDefaults.string(forKey: "battleMessage") {

    messageSpeed = spd
    
}

lang = userDefaults.bool(forKey: "lang")


let repository = MemoryRepository()


// cc97042 以降で 追記。やばかったら戻す。
let controllerChain = PokemonController(repo: repository, nextController: FieldConditionController(repo: repository, nextController: nil))


//print("BGMオプション: \(isMusicPlayed)です")
//print("バトルメッセージ: \(messageSpeed)です")


///////////////
/// 編集画面 ///
///////////////

var myPokemon1: Pokemon
var myPokemon2: Pokemon
var myPokemon3: Pokemon
var myPokemon4: Pokemon
var myPokemon5: Pokemon
var myPokemon6: Pokemon

var myPokemonArrayMainHas:[Pokemon] = []

var selectedMyPokemonIndex: [Int] = []


// 超・超・超・ださいが、しかたない
// すべては ポケモンをクラスでなく構造体で作らなかった 自分が悪い

var pokemonAryForFOE: [Pokemon] = []
var randIdx: [Int] = []


var pokeName: [String] {
    
    let ja: [String] = ["ピカチュウ", "フシギバナ", "リザードン", "カメックス", "ガブリアス", "フーディン", "コジョンド", "ニンフィア", "ルカリオ", "ゲンガー"]
    let en: [String] = ["Pikachu", "Bulbasaur", "Charizard", "Blastoise", "Garchomp", "Alakazam", "Mienshao", "Sylveon", "Lucario", "Gengar"]
    
    if lang == true {
        
        return ja
        
    } else {
        return en
    }
}


// HP 110
pokemonAryForFOE.append(Pokemon(name: pokeName[0], type1: .electric, type2: .null, ability: .seidenki, gender: .male, lv: 50, MAXHP: 110, HP: 110, ATTACK: 91, DEFFENSE: 60, S_ATTACK: 77, S_DEFFENSE: 70, SPEED: 156, move1: repository.Moves[0], move2: repository.Moves[1], move3: repository.Moves[2], move4: repository.Moves[3]))

// フシギバナ HP 153
pokemonAryForFOE.append(Pokemon(name: pokeName[1], type1: .grass, type2: .poison, ability: .overgrow, gender: .female, lv: 50, MAXHP: 153, HP: 153, ATTACK: 91, DEFFENSE: 135, S_ATTACK: 120, S_DEFFENSE: 167, SPEED: 100, move1: repository.Moves[4], move2: repository.Moves[5], move3: repository.Moves[6], move4: repository.Moves[7]))


pokemonAryForFOE.append(Pokemon(name: pokeName[2], type1: .fire, type2: .flying, ability: .blaze, gender: .female, lv: 50, MAXHP: 154, HP: 154, ATTACK: 149, DEFFENSE: 88, S_ATTACK: 145, S_DEFFENSE: 105, SPEED: 136, move1: repository.Moves[8], move2: repository.Moves[9], move3: repository.Moves[10], move4: repository.Moves[11]))


// カメックス HP155
pokemonAryForFOE.append(Pokemon(name: pokeName[3], type1: .water, type2: .null, ability: .torrent, gender: .female, lv: 50, MAXHP: 155, HP: 155, ATTACK: 92, DEFFENSE: 167, S_ATTACK: 105, S_DEFFENSE: 157, SPEED: 98, move1: repository.Moves[12], move2: repository.Moves[13], move3: repository.Moves[14], move4: repository.Moves[15]))


// gaburias HP 183
pokemonAryForFOE.append(Pokemon(name: pokeName[4], type1: .ground, type2: .dragon, ability: .roughskin, gender: .male, lv: 50, MAXHP: 183, HP: 183, ATTACK: 200, DEFFENSE: 115, S_ATTACK: 90, S_DEFFENSE: 105, SPEED: 154, move1: repository.Moves[16], move2: repository.Moves[17], move3: repository.Moves[18], move4: repository.Moves[19]))


// フーディン
pokemonAryForFOE.append(Pokemon(name: pokeName[5], type1: .psychic, type2: .null, ability: .innerfocus, gender: .male, lv: 50, MAXHP: 130, HP: 130, ATTACK: 63, DEFFENSE: 65, S_ATTACK: 205, S_DEFFENSE: 116, SPEED: 172, move1: repository.Moves[20], move2: repository.Moves[21], move3: repository.Moves[22], move4: repository.Moves[23]))

// コジョンド
pokemonAryForFOE.append(Pokemon(name: pokeName[6], type1: .fighting, type2: .null, ability: .reckless, gender: .female, lv: 50, MAXHP: 140, HP: 140, ATTACK: 177, DEFFENSE: 81, S_ATTACK: 103, S_DEFFENSE: 80, SPEED: 172, move1: repository.Moves[24], move2: repository.Moves[25], move3: repository.Moves[26], move4: repository.Moves[27]))

// ニンフィア
pokemonAryForFOE.append(Pokemon(name: pokeName[7], type1: .fairy, type2: .null, ability: .pixilate, gender: .male, lv: 50, MAXHP: 171, HP: 171, ATTACK: 76, DEFFENSE: 85, S_ATTACK: 178, S_DEFFENSE: 182, SPEED: 80, move1: repository.Moves[28], move2: repository.Moves[29], move3: repository.Moves[30], move4: repository.Moves[31]))

// ルカリオ
pokemonAryForFOE.append(Pokemon(name: pokeName[8], type1: .fighting, type2: .steel, ability: .steadfast, gender: .male, lv: 50, MAXHP: 145, HP: 145, ATTACK: 178, DEFFENSE: 90, S_ATTACK: 151, S_DEFFENSE: 106, SPEED: 99, move1: repository.Moves[32], move2: repository.Moves[33], move3: repository.Moves[34], move4: repository.Moves[35]))

// ゲンガー
pokemonAryForFOE.append(Pokemon(name: pokeName[9], type1: .ghost, type2: .poison, ability: .levitate, gender: .male, lv: 50, MAXHP: 135, HP: 135, ATTACK: 76, DEFFENSE: 80, S_ATTACK: 200, S_DEFFENSE: 96, SPEED: 162, move1: repository.Moves[36], move2: repository.Moves[37], move3: repository.Moves[38], move4: repository.Moves[39]))


//Pokemon(name: "Mew", type1: .psychic, type2: .null, ability: .overgrow, gender: .unknown, lv: 50, MAXHP: 175, HP: 175, ATTACK: 108, DEFFENSE: 120, S_ATTACK: 167, S_DEFFENSE: 121, SPEED: 152, move1: repository.Moves[20], move2: repository.Moves[23], move3: repository.Moves[32], move4: repository.Moves[37])





for cnt in 1...6 {
    
    while randIdx.count < cnt {
        
        let rand = Int(arc4random_uniform(10))
        
        if randIdx.index(of: rand) == nil {
            randIdx.append(rand)
        } else {
            continue
        }
    }
}

//print("選ばれたidxは \(randIdx) です")


var foePokemon1: Pokemon = pokemonAryForFOE[randIdx[0]]
var foePokemon2: Pokemon = pokemonAryForFOE[randIdx[1]]
var foePokemon3: Pokemon = pokemonAryForFOE[randIdx[2]]
var foePokemon4: Pokemon = pokemonAryForFOE[randIdx[3]]
var foePokemon5: Pokemon = pokemonAryForFOE[randIdx[4]]
var foePokemon6: Pokemon = pokemonAryForFOE[randIdx[5]]

var foePokemonAry = [foePokemon1, foePokemon2, foePokemon3, foePokemon4, foePokemon5, foePokemon6]


//for idx in 0...5 { //
    //print("選ばれたポケは \(foePokemonAry[idx].name) です")
//}



// 一度、これ書いてること忘れて、【なぜか保存できてないなー】って自爆してた。超絶注意！！！！
// ユーザーデフォルトをリセットするには、ここをコメントインすればOK o
//userDefaults.removeObject(forKey: "slot1")
//userDefaults.removeObject(forKey: "slot2")
//userDefaults.removeObject(forKey: "slot3")
//userDefaults.removeObject(forKey: "slot4")
//userDefaults.removeObject(forKey: "slot5")
//userDefaults.removeObject(forKey: "slot6")


// ビューから上記群プロパティをプリントするわけだが、
//  各プロパティが評価された後でないと正常にプリントされない(クラッシュはしないようだが。)
// ↓　の記述は、書く場所に気をつけて

// この中で、 myPokemon1-6に、セットされている
ArgsExecuteView().execute()


//////////////////
/// バトル画面用 ///
//////////////////


var stdIn = FileHandle.standardInput
var command = Command.SURRENDER
var data: [String] = []


let judge: Judge


// -r オプションでランダムにポケモンを選出した場合は、こっちのイニシャライザでjudgeが生成される
var tmpArg: [String] {
    return CommandLine.argc > 1 ? CommandLine.arguments : ["hoge", "hoge"]
}


// ランダムセレクトを指定したか? or スロットからロードするか? で、Judgeの初期化処理が変わります
if tmpArg[1] == "r" || tmpArg[1] == "-r" || tmpArg[1] == "--random" {
    
    // ランダムセレクト
    judge = Judge(pokeAry: myPokemonArrayMainHas)
    
} else {
    
//  print("よかった、引数0だとこっちに来ます")
    judge = Judge(storedPokeAry: myPokemonArrayMainHas)
}


// ターン数
var turn = 0


// MARK: ビュー生成ジェネレーターとそのコントローラ
var myBVC = BattleViewController(BF: judge.battleField, BIW: BattleInfoWindow(), BMQ: BattleMessageQueue())

ViewManipulation.initiate()

/////// *** end of global property *** ///////



// 音楽再生(止め方は知らない)
//let task = Process()
//task.launchPath = "/bin/bash"
//task.arguments = ["/Users/username/Desktop/TypeWriterOutput/TypeWriterOutput/PlayMusic.sh"]
//task.arguments = ["-c","./TypeWriter/PlayMusic.sh"]
//task.launch()



func canPokemonChange() -> Bool {
    
    var KOcount = 0
    
    for x in judge.battleField.myParty {
        
        if x.HP <= 0 {
            KOcount += 1
        }
    }
    
    // // 敵が残り1体の場合、そもそもポケモンチェンジはできない(=選ばれない)
    if KOcount >= 2 {
//        print("KOcount: \(KOcount)")
//        print("おい、俺！ もう残り一体なんだから ポケモンチェンジ　できないで")
        return false
    } else {
//        print("KOcount: \(KOcount)")
//        print("うん、まだ　チェンジできる")
        return true
    }
}


// masaが しょうぶを しかけてきた！ って出すためだけに存在する
judge.storeValueToTmpVar()
myBVC.outputBattleMessageLikeTypeWriter()


// SIGINTを捕捉するためだけに使われる
var signalReceived: Int32 = 0



// 最も外側のループ
outestloop: while true {
    
    
signal(SIGINT) { signal in
    
    
    // Ctrl + c で中断された場合、連勝カウントを0に
    UserDefaults.standard.set(0, forKey: "winCount")
    userDefaults.synchronize()
    
    // これ いるのか?
    signalReceived = 2
    
    if lang == true {
        print("アプリを終了しました。 また あそんでね。")
    } else {
        print("Terminated the App. Play again, thanks!")
    }
    
    ViewManipulation.displayCursor()
    
    ViewManipulation.resetOutputColor()
    
    exit(1)
}

outerloop: while true {
    
    
    // もし、handleCommand が無事に実行できビューが生成・返り、それがviewの中に格納されたら、
    if let view = controllerChain.handleCommand(command, data: data) {

        
        // コマンドを実行(ビューには反映されない、内部操作)。戦闘開始直後(0ターン目)はスキップ。
        if turn != 0 {
            
            
            // ここで、敵の行動をランダムで決定
            func decideFoeAct() {
                
                // AIを生成
                let myAI = AI(myPokemon: judge.battleField.myBattlePokemon, foePokemon: judge.battleField.foeBattlePokemon,foePokemonAry: judge.battleField.foeParty)
                
                judge.foeAction = myAI.generateAction()
                
            }
            
            decideFoeAct()
            
            
            // 先行後攻判定(ひるみの中で使われる)が、ここで毎回リセット
            judge.actOrder = nil
            
            
            
            // モデルが更新前されてしまう前に、現在のバトル・コンディションをtmp変数へ格納しておく
            judge.storeValueToTmpVar()
            
            
            // ここで、受け取ったコマンドに応じてモデル変化の処理を加える
            switch command {
                
                case .MOVE1:
                    judge.initiateTurnProcess(moveNo: 1)
                case .MOVE2:
                    judge.initiateTurnProcess(moveNo: 2)
                case .MOVE3:
                    judge.initiateTurnProcess(moveNo: 3)
                case .MOVE4:
                    judge.initiateTurnProcess(moveNo: 4)
                
                case .CHANGE_POKEMON:
                    
                    if canPokemonChange() {
                        
                        // ここに書くのではなく、 ループ終了時点(turn +1) と同じタイミングのほうが保守しやすくね
                        quit = false
                        
                        // ↓の関数内で、 quit が trueになる可能性がある
                        judge.pokemonChange()

                        if quit { // quit が trueなら
                            turn -= 1
                        } else { // quit以外が選ばれたら、プロセスを実行
                            judge.initiateTurnProcess(moveNo: 5)
                        }
                        
                    } else {
//                        print("チェンジ不可能　ぶりぶり")
                        // ここ　やばいかも　ねこだましとか　大丈夫？
                        turn -= 1
                    }
                
                
                // モデルに変化はないので、ここはこうで良い？
                case .CONDITION:
                    print("")
                case .SURRENDER:
                    print("")
                
                case .EXCEPTION:
                    print("")

            }
            
        } else {
            
//            print("そりゃ0ターン目だからね。なにもしないね。")
            //print("")
        }
        
        
        //コマンドライン引数に対応したビューの表示 →　ここ、なくてもよいのか？
//        view.execute()

        if command == .CONDITION {
            turn -= 1
            AnalyzeView().execute()
        }
        
        else {
            myBVC.outputBattleMessageWhenInputStandBy()
        }

        
        
    } else {
        fatalError("No view.")
    }

        if command == .CONDITION {
            
            let str: String = lang ? " \(judge.battleField.myBattlePokemon.name)は どうする? ([1-4/q])" : " What will \(judge.battleField.myBattlePokemon.name) do? ([1-4/q])"
            
            print("\(str)")
            
        } else {
            
            let str: String = lang ? " \(judge.battleField.myBattlePokemon.name)は どうする? ([1-4/p/c])" : " What will \(judge.battleField.myBattlePokemon.name) do? ([1-4/p/c])"

            print("\(str)")
        }
    
        print("")
        
        var moveIdx = 0
    

    
    for var x in (judge.battleField.myBattlePokemon.moveArray) {
        
        var moveName = x.name
        var power = x.power.description
        var accuracy = x.accuracy.description
        var type = String(describing: x.type).uppercased()
        var category = x.category.rawValue
        
        
        // 本当は、最大文字数は16(Parabolic Charge)なので、気をつけて
        if moveName.characters.count < 14 {
            
            let shortage = 14 - moveName.characters.count
            
            for _ in 1...shortage {
                moveName += " "
            }
        }
        
        
        if power.characters.count < 3 {
            
            let shortage = 3 - power.characters.count
            
            var emptyStr = ""
            
            for _ in 1...shortage {
                
                emptyStr += " "
            }
            
            power = emptyStr + power
        }
        
        
        if accuracy.characters.count < 3 {
            
            let shortage = 3 - accuracy.characters.count
            
            var emptyStr = ""
            
            for _ in 1...shortage {
                
                emptyStr += " "
            }
            
            accuracy = emptyStr + accuracy
        }
        
        
        if type.characters.count < 8 {
             
            let shortage = 8 - type.characters.count
            
            var emptyStr = ""
            
            for _ in 1...shortage {
                
                type += " "
            }
            
        }
        
        

        
        print(" ", terminator: "")
        
        var moveString000 = "\(moveIdx+1):"
        
        // 相性に応じて色を返る関数をコール
        ViewManipulation.affinityOutput(move: x, foePokemon: judge.battleField.foeBattlePokemon)
        
        print(moveString000, terminator: "")

        ViewManipulation.resetOutputColor()
        
        
        print(" ", terminator: "")

        
        
//        // 相性に応じて色を返る関数をコール
//        ViewManipulation.affinityOutput(move: x, foePokemon: judge.battleField.foeBattlePokemon)
        
        var moveString00 = "\(moveName)"
        
        print(moveString00, terminator: "")

//        ViewManipulation.resetOutputColor()
        
        
        
        var moveString0 = " \(power) - \(accuracy) - "
        
        print(moveString0, terminator: "")
        
        ViewManipulation.generateColor(colorString: type)
        
        let moveString2 = "\(type) "
        
        print(moveString2, terminator: "")
        
        ViewManipulation.resetOutputColor()
        
        let moveString3 = "- \(category) - \(x.desc)"
        
        print(moveString3)


        moveIdx += 1
        
    }
    
        print("")
    
    
        if command == .CONDITION {
            
            let str: String = lang ? " q: もどる" : " q: Quit "
            
            print("\(str)")
            
            
        } else {
            
            let str: String = lang ? " p: ポケモンチェンジ / c: コンディション" : " p: Pokemon Change / c: Check Condition"

            print("\(str)")
        }
    
    
    
    
//        print("")
//        print("\(judge.battleField.myBattlePokemon.name)は どうする？")
        ViewManipulation.displayCursor()
        print("")
//        print(">", terminator: "")
//        print("\u{001B}[2C", terminator: "")
//        ViewManipulation.displayCursor()

    
        /////////////////////////////////////////////////////
        // ここで毎ターン、1回ストップ！プレイヤーからのコマンド受付。 //
        /////////////////////////////////////////////////////
    
        let input = NSString(data:stdIn.availableData, encoding:String.Encoding.utf8.rawValue) ?? ""
        let scanner = Scanner(string:input as String).string
        let inputArray:[String] = scanner.split()
        
        if (inputArray.count > 0) {
            command = Command.getFromInput(inputArray.first!) ?? Command.MOVE1
            
            if (inputArray.count > 1) {
                data = Array(inputArray[1...inputArray.count - 1]);
            } else {
                data = [];
                //print("コマンドには何の引数もついてない")
            }
        }
    
    // ターン数の増加は、 99. の中で　することにしました
    turn += 1
        
    
}  // outerloop while end

} // outest loop








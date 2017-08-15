

import Foundation


//////////////////////////////////////////////////////////////////

// 何らかの事情で標準エラー出力したい場合はこうする(つっても今は使われてない)

class StandardErrorOutputStream: TextOutputStream {
    
    func write(_ string: String) {
        let stderr = FileHandle.standardError
        if let odata = string.data(using: String.Encoding.utf8) {
            stderr.write(odata)
        }
    }
}

//var standardError = StandardErrorOutputStream()
//print("\(strStream)", to: &standardError)

////////////////////////////////////////////////////////////////////



// MARK: バトル・ビュー コントローラ

struct BattleViewController {
    
    var BF: BattleField
    
    // 2つのビュージェネレーターの参照を持つ
    var battleInfoWindow: BattleInfoWindow
    var battleMessageQueue: BattleMessageQueue
    
    
    // タイプライター風に出力
    mutating func outputBattleMessageLikeTypeWriter() {
        
        
        var spd: Double {
            
            switch messageSpeed {
                
            case "slow":
                return 0.06
            case "middle":
                return 0.04
            case "fast":
                return 0.02
            default:
                return 0.04
            }
        }
        
        
        var itvl: Double {
            
            switch messageSpeed {
                
            case "slow":
                return 0.5
            case "middle":
                return 0.2
            case "fast":
                return 0.1
            default:
                return 0.3
            }
        }
        
        
        
        for _ in self.battleMessageQueue.msgAry {
        
        // 1文字ずつ出力
        var strStream = ""
        
        // いま、何文字めか
        var characterNo = 0
        
        // この時点ではカーソルは原点
        
        //let tmp = biw.battleInfoWindow
        
        // よしなに間を空けてから起動
//        Thread.sleep(forTimeInterval: 0.2)
        
        // 現在のバトル・メッセージの文字数だけループします...
        for _ in 1...self.dequeue().characters.count {
            
            // カーソルを原点へ
            ViewManipulation.moveCursorToOrigin()
            
            // バトルInfoウインドウの表示
            
            renewBIW(howToActivate: .tmpBF)
            
            
            
            // ここ！！！注意しろ！！！
            if judge.battleField.myBattlePokemon.HP <= 0 {
                ViewManipulation.redColor()
            }
            
            
            outputBattleInfoWindow()
            
            
            
            
            // カーソル位置を15,1に移動
            print("\u{001B}[15;1H", terminator: "")
            
            characterNo += 1
            
            strStream = dequeue().substring(to: battleMessageQueue.msgAry[battleMessageQueue.index].index(battleMessageQueue.msgAry[battleMessageQueue.index].startIndex, offsetBy: characterNo))
            
            // terminator "" と書くとエラー。くそはまった。
            print("\(strStream)")
            
            // よしなにスリープ
            
            Thread.sleep(forTimeInterval: spd)
            
//            Thread.sleep(forTimeInterval: 0.02)
        }
        
        Thread.sleep(forTimeInterval: 0.3)
            
        // 次のキューへ移動
        self.battleMessageQueue.indexPlus()
        
        
        } // バトルメッセージ1個ぶんの処理、終了。これを1単位としてキュー個分ループする
        
        // 最後に、スタックされたキューをリセットし、キューの現在位置を最初に戻しておく。
        self.battleMessageQueue.msgAry = [" "] // たぶん、ここ ""だと count = 0 となって はまるのでは？
        self.battleMessageQueue.index = 0
        
        
        // よしなにスリープ
        //Thread.sleep(forTimeInterval: 0.1)
        Thread.sleep(forTimeInterval: itvl)
    
    }
    
    
    // 入力待ち時のビュー
    mutating func outputBattleMessageWhenInputStandBy() {
        
        // 画面をクリア
        ViewManipulation.clear()

        // カーソルを原点へ
        ViewManipulation.moveCursorToOrigin()
        
        // モデルが更新前されてしまう前に、現在のバトル・コンディションをtmp変数へ格納しておく
        judge.storeValueToTmpVar()
        
        
//        print("この！\(judge.tmp_myPokemonHP)だぞ")
        
        // 現在の味方ポケモンHPに応じて出力色をチェンジ
        func judgeOutputColor() {

            ViewManipulation.resetOutputColor()

            // 出力を黄色にして警告
            if judge.tmp_myPokemonHP < Int(Double(judge.tmp_foePokemonMAXHP) * 0.2) {

                //            print("\u{001B}[1;1H", terminator: "")
                print("\u{1b}[38;5;11m")
                //          print("\u{001B}[2J", terminator: "")   // 画面クリア
                //          print("\u{001B}[1;1H", terminator: "")
            }

            // 出力を赤にしてゴア表現(ここは絶対通らないはず)
            if judge.tmp_myPokemonHP <= 0 {
                print("\u{1b}[31m")
                //            print("\u{001B}[2J", terminator: "")   // 画面クリア
                //            print("\u{001B}[1;1H", terminator: "")
            }
        }
        
        judgeOutputColor()
        
        
        
        
        // バトルInfoウインドウの表示
        renewBIW(howToActivate: .currentBF)
        outputBattleInfoWindow()
        
        // カーソル位置を16,1に移動
        print("\u{001B}[15;1H", terminator: "")
        
//        ViewManipulation.resetOutputColor()
    }
    
    
    
    // 「自分のダメージ自身を増減」するときはこっちの関数を使う
    mutating func HPchangeAnimeForItself(tmp_myPokeHP: inout Int, tmp_foePokeHP: inout Int, damage: Int, whichTurn: Bool) {
        
        
//        print("きてるぜ！！ どっちのターンかは、\(whichTurn)だ")
        
        let tuple: (tmp_myPokeHP: Int, tmp_foePokeHP: Int, damage: Int) = (tmp_myPokeHP, tmp_foePokeHP, damage)
        
        
        // 一時格納値の一時格納変数(くそわかりにくい)
        var tmp_tmpMyPokeHP = tuple.tmp_myPokeHP
        var tmp_tmpFoePokeHP = tuple.tmp_foePokeHP
        
        
//        var spd: Double {
//        
//            switch messageSpeed {
//                
//                case "slow":
//                    return 0.3
//                case "middle":
//                    return 0.15
//                case "fast":
//                    return 0.005
//                default:
//                    return 0.15
//            }
//        }
 
        if whichTurn {
//            print("味方のアニメ前HP: \(tmp_tmpMyPokeHP) 味方のアニメ後HP: \(judge.battleField.myBattlePokemon.HP) です")
        } else {
//            print("敵のアニメ前HP: \(tmp_tmpFoePokeHP) 敵のアニメ後HP: \(judge.battleField.foeBattlePokemon.HP) です")
        }
        
        // カーソルを隠す
        ViewManipulation.deleteCursor()
        
        switch whichTurn {
            
            case true:
            
//            print("きてるんだ")
//            
//            print("モデル処理後の味方HP: \(judge.battleField.myBattlePokemon.HP)")
//            print("一時格納・一時格納味方HP: \(tmp_tmpMyPokeHP)")
//            print("与ダメ: \(tuple.damage)")
            
                while judge.battleField.myBattlePokemon.HP < tmp_tmpMyPokeHP {
                
//                print("きてんの？1回でも？")
                
                    tmp_myPokeHP -= 1
                    tmp_tmpMyPokeHP -= 1
                
                    // バトルInfoウインドウの表示
                    renewBIW(howToActivate: .tmpBF)
                    outputBattleInfoWindow()
                    
                    // HPに応じた出力色の判定
                    changeOutputColor(currentHP: tmp_myPokeHP)
                    
                    // 画面クリア + カーソルを原点へ
                    ViewManipulation.clear()
                    ViewManipulation.moveCursorToOrigin()
            
                    ViewManipulation.sleepForViewControl(interval: 0.005)
                    
                    if tmp_tmpMyPokeHP <= 0 {
                        break
                    }
                }
            
            
            case false:
            
            
//            print("モデル処理後の敵HP: \(judge.battleField.foeBattlePokemon.HP)")
//            print("一時格納・一時格納敵HP: \(tmp_tmpFoePokeHP)")
//            print("与ダメ: \(tuple.damage)")
            
            
                while judge.battleField.foeBattlePokemon.HP < tmp_tmpFoePokeHP {
                
                
                    tmp_foePokeHP -= 1
                    tmp_tmpFoePokeHP -= 1
                
                
                    // バトルInfoウインドウの表示
                    renewBIW(howToActivate: .tmpBF)
                    
                    outputBattleInfoWindow()
                    
                    
                    // HPに応じた出力色の判定
                    //changeOutputColor(currentHP: tmp_myPokeHP)
                    
                    // 画面クリア + カーソルを原点へ
                    ViewManipulation.clear()
                    ViewManipulation.moveCursorToOrigin()
                    
                    
                    
                    ViewManipulation.sleepForViewControl(interval: 0.005)
                    
                    if tmp_tmpFoePokeHP <= 0 {
                        break
                    }
                }
        }
        
        ViewManipulation.sleepForViewControl(interval: 0.3)
        
        // カーソル再表示(ぶっちゃけないほうがいいが)
        ViewManipulation.displayCursor()
        
    }
    
 
    mutating func HPchangeAnimationGenerator(tmp_myPokeHP: inout Int, tmp_foePokeHP: inout Int, damage: Int, whichTurn: Bool) {
        
//        print("きてるぜ！！ どっちのターンかは、\(whichTurn)だ")
        
        let tuple: (tmp_myPokeHP: Int, tmp_foePokeHP: Int, damage: Int) = (tmp_myPokeHP, tmp_foePokeHP, damage)
        
        
        // 一時格納値の一時格納変数(くそわかりにくい)
        var tmp_tmpMyPokeHP = tuple.tmp_myPokeHP
        var tmp_tmpFoePokeHP = tuple.tmp_foePokeHP
        
        
        if whichTurn {
//            print("敵のアニメ前HP: \(tmp_tmpFoePokeHP) 敵のアニメ後HP: \(judge.battleField.foeBattlePokemon.HP) です")
        } else {
//            print("味方のアニメ前HP: \(tmp_tmpMyPokeHP) 敵のアニメ後HP: \(judge.battleField.myBattlePokemon.HP) です")
        }
        
        // カーソルを隠す
        ViewManipulation.deleteCursor()
 
        switch whichTurn {
            
            case true:
                
//                print("モデル処理後の敵HP: \(judge.battleField.foeBattlePokemon.HP)")
//                print("一時格納・一時格納敵HP: \(tmp_tmpFoePokeHP)")
//                print("与ダメ: \(tuple.damage)")
                
                while judge.battleField.foeBattlePokemon.HP < tmp_tmpFoePokeHP {
                    
//                    print("きてんの？1回でも？")
                    
                    tmp_foePokeHP -= 1
                    tmp_tmpFoePokeHP -= 1
                    
                    // バトルInfoウインドウの表示
                    renewBIW(howToActivate: .tmpBF)
                    outputBattleInfoWindow()

                    
                    // 画面クリア + カーソルを原点へ
                    ViewManipulation.clear()
                    ViewManipulation.moveCursorToOrigin()
                    
                    ViewManipulation.sleepForViewControl(interval: 0.005)
                    
                    if tmp_tmpFoePokeHP <= 0 {
                        break
                    }
                    
                }
            
            case false:
                
//                print("モデル処理後の味方HP: \(judge.battleField.myBattlePokemon.HP)")
//                print("一時格納・一時格納味方HP: \(tmp_tmpMyPokeHP)")
//                print("与ダメ: \(tuple.damage)")
                
                while judge.battleField.myBattlePokemon.HP < tmp_tmpMyPokeHP {
                    
                    
                    tmp_myPokeHP -= 1
                    tmp_tmpMyPokeHP -= 1
                    
                    
                    // バトルInfoウインドウの表示
                    renewBIW(howToActivate: .tmpBF)
                    
                    outputBattleInfoWindow()
                    
                    
                    // HPに応じた出力色の判定
                    changeOutputColor(currentHP: tmp_myPokeHP)
                    
                    // 画面クリア + カーソルを原点へ
                    ViewManipulation.clear()
                    ViewManipulation.moveCursorToOrigin()
                    
                    ViewManipulation.sleepForViewControl(interval: 0.005)
                    
                    if tmp_tmpMyPokeHP <= 0 {
                        break
                    }
                }
            
            // *** //
                
            // この値は、「ひんしになったとき、出力文字が赤になるまでの間隔」に影響するので注意。
            // ここに依存したくなかったら、↑の　// *** //　のとこにでも、赤にするメソッド呼べばいいんじゃないの
//            ViewManipulation.sleepForViewControl(interval: 3)
        }
        
        // カーソル再表示(ぶっちゃけないほうがいいが)
        ViewManipulation.displayCursor()
        
    }

    
    enum HowToActivate: String {
        case currentBF = "currentBF"
        case tmpBF = "tmpBF"
    }
    
    
    // HPが　-1でも更新される(減る)たび、これを毎回実行しないと、info画面上の情報が一切更新されない
    mutating func renewBIW(howToActivate: HowToActivate) {
      
        
        switch howToActivate {
            
        case .currentBF:
            battleInfoWindow.battleInfoString = FunctionCalledFromMain.launchConditionView(BF: judge.battleField)
            
        case .tmpBF:
            battleInfoWindow.battleInfoString = FunctionCalledFromMain.launchConditionView2()
            
        }

    }
    
    // バトル・ウインドウを出力
    mutating func outputBattleInfoWindow() {
        
        print("\(battleInfoWindow.battleInfoString)", terminator: "")
        
    }
    
    
    // バトル・メッセージ・キューにメッセージを追加
    mutating func enqueue(reveivedStr: String) {
        
        battleMessageQueue.msgAry.append(reveivedStr)
        
        
        //        self.msgAry.append("") // [0]の便宜を図る都合上のダミー
        //        self.msgAry.append("ピカチュウの 10まんボルト！\n")
        //        self.msgAry.append("リザードンの かえんほうしゃ！\n")
    }
    
    
    // 現在の位置のバトル・メッセージ・キューを返す
    mutating func dequeue() -> String {
        
        return battleMessageQueue.msgAry[battleMessageQueue.index]
        
    }
    
    
    // dequeue()を通して、現在の位置の バトル・メッセージ・キューを出力
    mutating func outputBattleMessage() {
        
        print(self.dequeue(), terminator: "")
        
    }
    
    mutating func changeOutputColor(currentHP: Int) {
        
        
        let hako = [BF.myBattlePokemon, BF.foeBattlePokemon]
        
        
//        // 通常時は緑の出力
//        if hako[0].HP < hako[0].MAXHP {
//            ViewManipulation.greenColor()
//        }
        
        
        // 出力を黄色にして警告
        if currentHP <= Int(Double(hako[0].MAXHP) * 0.2) {
            
            //            print("\u{001B}[1;1H", terminator: "")
            print("\u{1b}[38;5;11m")
            //          print("\u{001B}[2J", terminator: "")   // 画面クリア
            //          print("\u{001B}[1;1H", terminator: "")
        }
        
        
        // 出力を赤にしてゴア表現
        if currentHP <= 0 {
            print("\u{1b}[31m")
            //            print("\u{001B}[2J", terminator: "")   // 画面クリア
            //            print("\u{001B}[1;1H", terminator: "")
        }
        
    }
    
    
    init(BF: BattleField, BIW: BattleInfoWindow, BMQ: BattleMessageQueue) {
        
        self.BF = BF
        
        self.battleInfoWindow = BIW
        self.battleMessageQueue = BMQ
    }
    
}


///////////////////////////////////


// MARK: バトル・ウインドウ 構造体


struct BattleInfoWindow {
    
    // いま、何番目のキューの位置にいるか
    //    var index = 0
    
    
    // 出力する戦闘Info画面
    var battleInfoString: String = ""
    
}


////////////////////////////////////////////////////////


// MARK: バトル・メッセージ・キュー 構造体

struct BattleMessageQueue {
    
    
    // いま、何番目のキューの位置にいるか
    var index = 0
    
    mutating func indexPlus() {
        index += 1
    }
    
    // 各バトル・メッセージがここにスタックされる
    
//    let str: String = lang ? "masa has \nissueed a challenge!" : "masaが\nしょうぶを しかけてきた!"
    
    var msgAry: [String] = [(lang ? "masaが\nしょうぶを しかけてきた!" : "masa has issued a challenge!")]
    
    
}


//////////////////////////////////////////////////////////


// MARK: ビュー操作用 汎用関数クラス

class ViewManipulation {
    
    // どこかで1回やっとけ。 画面の初期設定(カーソル消去・画面クリア・カーソルを原点に)
    class func initiate() {
    
        deleteCursor() // カーソルを非表示に
        clear() // クリア
        moveCursorToOrigin() // カーソルを原点に
    }
    
    class func greenColor() {
        print("\u{1b}[32m", terminator: "") // 出力を緑に
    }
    
    class func yellowColor() {
        print("\u{1b}[33m", terminator: "") // 出力を黄色に
    }
    
    class func redColor() {
        print("\u{1b}[31m", terminator: "") // 出力を赤に
    }
    
    
    
    class func deleteCursor() {
        print("\u{001B}[?25l", terminator: "") // カーソル消去
    }
    
    class func displayCursor() {
        print("\u{001B}[?25h", terminator: "") // カーソル再表示
//        print("\u{001B}[?25h") // カーソル再表示
    }
    
    class func clear() {
        print("\u{001B}[2J", terminator: "") // クリア
    }
    
    class func moveCursorToOrigin() {
        print("\u{001B}[1;1H", terminator: "") // カーソル位置を原点に移動
    }
    
    // 上下左右へ移動 てか、macのterminalの問題なのか？これら全部効いてない。おい
    
    class func moveCursorToUp() {
        print("\u{001B}[1A", terminator: "") // カーソル位置を↑に移動
    }
    
    class func moveCursorToDown() {
        print("\u{001B}[1B", terminator: "") // カーソル位置を↓に移動
    }
    
    class func moveCursorToRight() {
        print("\u{001B}[1C", terminator: "") // カーソル位置を→に移動
    }
    
    class func moveCursorToLeft() {
        print("\u{001B}[1D", terminator: "") // カーソル位置を←に移動
    }
    
    class func resetOutputColor() {
        print("\u{001B}[0m", terminator: "") // 出力を白に戻す
    }
    
    class func sleepForViewControl(interval: TimeInterval) {
        Thread.sleep(forTimeInterval: interval)
    }
    
    
    class func generateColor(colorString: String) {
        
        switch colorString {
            
        case "BUG     ":
            print("\u{1b}[38;5;158m", terminator: "") // 出力を赤に
            
        case "DARK    ":
            print("\u{1b}[38;5;243m", terminator: "") // 出力を赤に
            
        case "DRAGON  ":
            print("\u{1b}[38;5;141m", terminator: "") // 出力を赤に
            
        case "ELECTRIC":
            print("\u{1b}[38;5;11m", terminator: "") // 出力を赤に
            
        case "FAIRY   ":
            print("\u{1b}[38;5;219m", terminator: "") // 出力を赤に
            
        case "FIGHTING":
            print("\u{1b}[38;5;202m", terminator: "") // 出力を赤に
            
        case "FIRE    ":
            print("\u{1b}[38;5;9m", terminator: "") // 出力を赤に
            
        case "FLYING  ":
            print("\u{1b}[38;5;51m", terminator: "") // 出力を赤に
            
        case "GHOST   ":
            print("\u{1b}[38;5;129m", terminator: "") // 出力を赤に
            
        case "GRASS   ":
            print("\u{1b}[38;5;10m", terminator: "") // 出力を赤に
            
        case "GROUND  ":
            print("\u{1b}[38;5;181m", terminator: "") // 出力を赤に
            
        case "ICE     ":
            print("\u{1b}[38;5;48m", terminator: "") // 出力を赤に
            
        case "NORMAL  ":
            print("\u{1b}[38;5;15m", terminator: "") // 出力を赤に
            
        case "POISON  ":
            print("\u{1b}[38;5;141m", terminator: "") // 出力を赤に
            
        case "PSYCHIC ":
            print("\u{1b}[38;5;201m", terminator: "") // 出力を赤に
            
        case "ROCK    ":
            print("\u{1b}[38;5;95m", terminator: "") // 出力を赤に
            
        case "STEEL   ":
            print("\u{1b}[38;5;3m", terminator: "") // 出力を赤に
            
        case "WATER   ":
            print("\u{1b}[38;5;81m", terminator: "") // 出力を赤に
            
        default:
            break
        }
    }
    
    
    class func affinityOutput(move: Move, foePokemon: Pokemon) {
        
        // すべての相性がつまった、汗と涙の結晶
//        let affinityAry = Chemistry.chemistry
        
        
        
        // STEP3-2: 弱点判定(なお、これは"攻撃者"から見た相性)
        let chemistry1: Double
        let chemistry2: Double
        
        
        chemistry1 = Chemistry.chemistry[move.type.rawValue][foePokemon.type1.rawValue]
        chemistry2 = Chemistry.chemistry[move.type.rawValue][foePokemon.type2.rawValue]
        

        // ステータスわざは、タイプの相性なんか関係ないので、装飾しない
        if move.category == .status {
            return
        }
        
//      print("相性係数は \(chemistry1) \(chemistry2) です")
        
        switch chemistry1 * chemistry2 {
            
            case 4.0, 2.0:
               
                print("\u{1b}[1;4;36m", terminator: "") //
            
            case 0.5, 0.25:
                
                print("\u{1b}[1;4;38;5;166m", terminator: "") // 出力を赤に
            
            case 0:
                print("\u{1b}[1;4;31m", terminator: "") // 出力を赤に
            
            default:
                break
        }
        
    }
    
}

///////////////////////////////////////////////////////////

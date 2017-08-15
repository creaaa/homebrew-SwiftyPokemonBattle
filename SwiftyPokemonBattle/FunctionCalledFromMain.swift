// #!/usr/bin/swift

import Foundation

extension String {
    
    func makeSpace(str: String) -> String {
        
        
        var pokeName = str
        
        // 日本語
        switch lang {
            
            case true:
            
                if str.characters.count < 6 {
                    
                    let shortage = 6 - str.characters.count
                    
                    for _ in 1...shortage {
                        
                        pokeName += "  "
                        
                    }
                }
            
            case false:
            
                if str.characters.count < 10 {
                    
                    let shortage = 10 - str.characters.count
                    
                    for _ in 1...shortage {
                        
                        pokeName += " "
                        
                    }
                }
        }
        
        return pokeName
        
    }
    
    
}




class FunctionCalledFromMain {
    
    // コマンドライン引数に応じた処理をコールする関数
    class func launchArgsExecuteView() {
        
        let task = Process()
        
        task.launchPath = "/bin/bash"
        
        // この 1 というのが直感的ではなくてハマる。とりあえず難しく考えずコピペしとけ
        var arguments: [String] {
            return CommandLine.argc > 1 ? CommandLine.arguments : ["", ""]
        }
        
        // MARK: コマンドライン引数は ここで実行できます
//        print(arguments)
        
        if arguments[1] == "s" || arguments[1] == "-s" {
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "bgm")
            userDefaults.synchronize()
            
//            print("BGMがランダムで再生されるオプションを設定しました。")
            
            print("")
            
            print("This option will be implumented in near future...")
            
            print("")
            
            exit(1)
        }
        
            
            
        else if arguments[1] == "l" || arguments[1] == "-l" || arguments[1] == "--language" {
            
            let userDefaults = UserDefaults.standard
            
            lang = userDefaults.bool(forKey: "lang")
            
            print("")
            
            if lang == true {
                
                userDefaults.set(false, forKey: "lang")
                
                userDefaults.synchronize()

                print("set battle message: 'English'.")
                
            } else {
                
                userDefaults.set(true, forKey: "lang")
                
                userDefaults.synchronize()
                
                print("バトルメッセージ: '日本語'を設定しました。")
            }
                
            print("")
            
            exit(1)
            
        }
            
            
            
        else if arguments[1] == "h" || arguments[1] == "-h" || arguments[1] == "help" || arguments[1] == "--help" {
            
            
            ViewManipulation.clear()
            ViewManipulation.moveCursorToOrigin()
            
            if lang == true {
                
                print("")
                print("                     Swifty Pokemon Battle α (ver 1.0)")
                print("")
                print("\u{1b}[1;4m", terminator: "") // 太字
                print(" - ランダムバトル！ (推奨: はじめての方は まずこちらから 遊んでね)")
                ViewManipulation.resetOutputColor()
                //            print("")
                print("     ./spb -r")
                print("")
                print(" - あらかじめ保存したポケモンでバトル！ ※ エキスパート向け")
                print("   (すべてのスロットにポケモンがセットされていないと 実行できません)")
                //            print("")
                print("     ./spb")
                print("")
                print(" - スロット番号を指定して ポケモンをセット")
                //            print("")
                print("     ./spb [1 or 2 or 3 or 4 or 5 or 6]")
                //            print("")
                print("         e.g. スロット1にセットしたい →  ./spb 1")
                print("")
                print(" - バトルメッセージのスピードを変更 (おそい / ふつう<デフォルト> / はやい)")
                //            print("")
                print("     ./spb [--slow or --middle or --fast]")
                print("")
                print(" - 言語の切り替え (英語<デフォルト> / 日本語)")
                //            print("")
                print("     ./spb -l")
                print("")
            
            } else {
        
                print("")
                print("                     Swifty Pokemon Battle α (ver 1.0)")
                print("")
                print("\u{1b}[1;4m", terminator: "") // 太字
                print(" - Play random battle (Recommended: Please play from this mode)")
                ViewManipulation.resetOutputColor()
    //            print("")
                print("     ./spb -r")
                print("")
                print(" - Play battle by Pokemons you've stored in advance ※ For Expert")
                print("   (You can't select this option before you set Pokemon to slot 1-6)")
    //            print("")
                print("     ./spb")
                print("")
                print(" - Store Pokemon you like by designating Slot Number")
    //            print("")
                print("     ./spb [1 or 2 or 3 or 4 or 5 or 6]")
    //            print("")
                print("         e.g. Want to set Pokemon to Slot 1 →  ./spb 1")
                print("")
                print(" - Change speed of battle message (slow / middle <Default> / fast)")
    //            print("")
                print("     ./spb [--slow or --middle or --fast]")
                print("")
                print(" - Toggle language (English <Default> / Japanese)")
                //            print("")
                print("     ./spb -l")
                print("")
            
        }
        
            exit(1)
        }
        
        
        else if arguments[1] == "--slow" || arguments[1] == "--middle" || arguments[1] == "--fast" {
            
            let userDefaults = UserDefaults.standard
            
            switch arguments[1] {
                case "--slow":
                    userDefaults.set("slow", forKey: "battleMessage")
                    userDefaults.synchronize()
                    
                    if lang == true {
                        print("")
                        print("バトルメッセージ: 'おそい' を 設定しました。")
                        print("")
                    } else {
                        print("")
                        print("Set Battle Message Speed: 'Slow'.")
                        print("")
                    }
                case "--middle":
                    userDefaults.set("middle", forKey: "battleMessage")
                    userDefaults.synchronize()
                    
                    if lang == true {
                        print("")
                        print("バトルメッセージ: 'ふつう' を 設定しました。")
                        print("")
                    } else {
                        print("")
                        print("Set Battle Message Speed: 'Middle'.")
                        print("")
                    }
                case "--fast":
                    userDefaults.set("fast", forKey: "battleMessage")
                    userDefaults.synchronize()
                    
                    if lang == true {
                        print("")
                        print("バトルメッセージ: 'はやい' を 設定しました。")
                        print("")
                    } else {
                        print("")
                        print("Set Battle Message Speed: 'Fast'." )
                        print("")

                    }
                default:
                    print("irregular!")
            }
            
            exit(1)
        }
        
        
        
        else if arguments[1] == "r" || arguments[1] == "-r" || arguments[1] == "--random" {
        
        
        // MARK: ここで 味方ポケモン セットできますよ。
        // ポケモンをおまかせセットして選出画面へ遷移するオプション
            
        var randIdx: [Int] = []

        // ランダムはこちら。
            
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
            
        
        // 直接指定するのはこちらです。
        // この時点で オブジェクトのじょうたいで　セットされているのが理想だわ 多分
        myPokemon1 = repository.Pokemons[randIdx[0]]
        myPokemon2 = repository.Pokemons[randIdx[1]]
        myPokemon3 = repository.Pokemons[randIdx[2]]
        myPokemon4 = repository.Pokemons[randIdx[3]]
        myPokemon5 = repository.Pokemons[randIdx[4]]
        myPokemon6 = repository.Pokemons[randIdx[5]]
        
        let pokemonSelectView = PokemonSelectView()
        pokemonSelectView.execute()
            
        }
        
        // スロットを指定して、その1箇所のポケモンだけを変更したいときのオプション
        else if arguments[1] == "1" || arguments[1] == "2" || arguments[1] == "3" || arguments[1] == "4" || arguments[1] == "5" || arguments[1] == "6" {
            
            let pokemonEditView = PokemonEditView()
            pokemonEditView.execute(cmd: Int(arguments[1])!)
        }
        
//        print("コマヒキは\(arguments)だ")
        
        
        // コマンドライン引数が何もなければ、プリセットされたポケモン6体からバトル用3体を選ぶ画面へ移動
        else if arguments.count == 2 && arguments[1] == "" {
            
//            print("はいきたー。解凍するよー。")
            
            //var myPokeAry = [myPokemon1, myPokemon2, myPokemon3, myPokemon4, myPokemon5, myPokemon6]
            var myPokeAry: [Pokemon] = []
            
            
            let keyAry = ["slot1", "slot2", "slot3", "slot4", "slot5", "slot6"]
            
            for idx in 0...5 {
        
                let storedPokemon = userDefaults.object(forKey: keyAry[idx]) as? NSData
                
//                print("\(keyAry[idx])おら！")
                
//                  print("\(storedPokemon)だぜ!!")
                
                if let storedPokemon = storedPokemon {
                    
                    ///////////////////////////////
                    /// デシリアライズされてるのはここ！
                    /// なぜか関数内に入れないが。。
                    //////////////////////////////
                    
                    
                    let deSeriarizedPokemon = NSKeyedUnarchiver.unarchiveObject(with: storedPokemon as Data) as? Pokemon
                    
                    
                    //myPokeAry[idx] = deSeriarizedPokemon!
                    myPokeAry.append(deSeriarizedPokemon!)
                    
//                    print(myPokeAry[idx].move1.process)
                    
                } else {
                    print("")
                    if lang == true {
                    
                        print("[Error]:\nスロット\(idx+1)に ポケモンが セット されて いません！\nすべての スロットに ポケモンを セットしてから また おこしください。")
                        print("また、'path/spb -r' と してい することで、\nそくざに ランダムバトルを たのしむ ことが できます。")
                    
                    } else {
                        
                        print("[Error]:\nNo Pokemon is set on Slot \(idx+1).\nExecute after you set Pokemons to all slots...")
                        print("Alternatively, you can play right now by designating 'path/spb -r'.")
                        
                        
                    }
                    
                    print("")
                    exit(1)
                }
            }
            
//            print("無事 6体のポケモンが 解凍されました...")
            
            myPokemon1 = myPokeAry[0]
            myPokemon2 = myPokeAry[1]
            myPokemon3 = myPokeAry[2]
            myPokemon4 = myPokeAry[3]
            myPokemon5 = myPokeAry[4]
            myPokemon6 = myPokeAry[5]
            
            
            let pokemonSelectView = PokemonSelectView()
            pokemonSelectView.execute()
        
        } else {
            
            if lang == true {
                print("オプション \(arguments[1]) は 存在しません。アプリを終了します...")
            } else {
                print("Option \(arguments[1]) doesn't exist. Terminate App...")
            }
            
            exit(1)
        }
    }
    
    
    
    
    
    // 指定したスロットにポケモンを設定できる画面
    class func launchPokemonEditView(cmd: Int) {
    
        ViewManipulation.clear()
        ViewManipulation.moveCursorToOrigin()
        
        
        
//        print("無事到着〜 受け取ったコマンド引数は\(cmd)だぜ")
        
        if lang == true {
            
            print("")
            print("slot\(cmd)に セットする ポケモン名を にゅうりょく して ください...")
            print("")
            print("【選択可能ポケモンリスト】")
            print("")
            print("ピカチュウ / フシギバナ / リザードン / カメックス / ガブリアス / フーディン / コジョンド / ニンフィア / ルカリオ / ゲンガー")
            print("")
//            print("'q'と入力すると、このアプリを終了します。")
//            print("")
            
        } else {
    
            print("")
            print("Input Pokemon Name you want to set slot \(cmd)...")
            print("(Please use a capital letter for beginning of Pokemon name.)")
            print("")
            print("【Pokemon List you can select】")
            print("")
            print("Pikachu / Bulbasaur / Charizard / Blastoise / Garchomp / Alakazam / Mienshao / Sylveon /  Lucario / Gengar")
            print("")
//            print("(input 'q' for quit in case you want to quit.)")
//            print("")
        }
    
        
        var data: [String] = []
        
        let stdIn = FileHandle.standardInput
        let input = NSString(data:stdIn.availableData, encoding:String.Encoding.utf8.rawValue) ?? "hoge"
        let scanner = Scanner(string:input as String).string
        var inputArray:[String] = scanner.split()
        
        if (inputArray.count > 0) {
            
            if (inputArray.count > 1) {
                data = Array(inputArray[1...inputArray.count - 1]);
            } else {
                data = [];
                //print("コマンドには何の引数もついてない")
            }
        }
        
        //////////
        // !!!: バグ ユーザーのコマンドライン引数で、何も入れずエンターされるとエラー。注意
        //
        
        // エンターで落ちる不都合の回避用
        if inputArray.isEmpty {
            
            inputArray.append("error")
            // print("なおしといた")
        }
        
        
//        print("ユーザーは \(inputArray[0])と 入力してきたよ")
        
        
        // MemoryRepositoryに存在する、すべてのポケモンの名前が格納される
        var pokeNameAry: [String] = []
        
        for eachPokeName in repository.Pokemons {
            
            pokeNameAry.append(eachPokeName.name)
            //      print(pokeNameAry)
        }
        
        var loopCount = 0
        
        // UserDefaultsにポケモンを保存する関数
        func storePokemonToUserDefault(slot: Int, designatedPokemonName: String) {
        
            // 全ポケモンを対象に...
            for eachPoke in repository.Pokemons {
                
                // もし、入力したポケモンがこの世に存在したら...
                if designatedPokemonName == eachPoke.name {
                    
//                    let ud = UserDefaults.standard
                    
                    
                    
                    let keyAry = ["slot1", "slot2", "slot3", "slot4", "slot5", "slot6"]
                    
                    // すでにスロット内に存在するポケモンの名前が格納される配列
                    var derivedPokeName: [String] = []

                    for idx in 0...5 {
                        
//                        print("\(idx)です　今")
                        
                        let storedPokemon = userDefaults.object(forKey: keyAry[idx]) as? NSData
                        
//                        print(storedPokemon)
                        
                        // storedPokemon( "slot1", "slot2", "slot3"...というキーで、既に保存されているポケモンがいたら...)
                        if let _ = storedPokemon  {
                        
                            let deSeriarizedPokemon = NSKeyedUnarchiver.unarchiveObject(with: storedPokemon as! Data) as? Pokemon
                            
                            if let poke = deSeriarizedPokemon {
                                
                                //print("デシリアライズされたスロット1: \(poke1.move1.buffLevel)")
                                //print(poke.name, poke.ATTACK, poke.move3)
                                derivedPokeName.append(poke.name)
//                                print(derivedPokeName)
                            }
                        }
                    }
                    
                    // UserDefaultのslot1〜6をチェックし、同名のポケモンが既に登録されていた場合、
                    // 新たにそのポケモンの追加はできない
                    if let slot = derivedPokeName.index(of: designatedPokemonName) {
                        
                        if lang == true {
                            print("\(designatedPokemonName)は 既にスロット\(slot+1)に存在します。")
                            print("アプリを終了します...")
                        } else {
                            print("\(designatedPokemonName) already exists on Slot\(slot+1).")
                            print("Terminate this App...")
                        }
                        exit(1)
                    }
                    
//                    print("見事！ヒットしました！")
//                    
//                    print("つまり、\(eachPoke.name)の ことである！！")
                    
                    let serializedPokemon = NSKeyedArchiver.archivedData(withRootObject: eachPoke)
                    
                    
//                    print("\(serializedPokemon)だっちゅーの")
//                    print("\(keyAry[slot-1])だっちゅーの")
//                    
//                    print("キーは、\(keyAry[slot-1])の ことである！！")
                    
                    userDefaults.set(serializedPokemon, forKey: keyAry[slot-1])
                    userDefaults.synchronize()
                    
                    //print("スロット\(slot)に \(eachPoke.move1.name)を 保存しました...")
                    
                    if lang == true {
                        print("スロット\(slot)に \(eachPoke.name)を 保存しました...")
                    } else {
                        print("saved \(eachPoke.name) on Slot\(slot)...")
                    }
                    
                }
                
                loopCount += 1
            }
        }
        
        // 保存処理を行うかどうか
        var flag = false
        
        for eachPokeName in pokeNameAry {
            if inputArray[0] == eachPokeName {
                flag = true
            }
        }
        
        if flag == true {
            storePokemonToUserDefault(slot: cmd, designatedPokemonName: inputArray[0])
            
//            userDefaults.object(forKey: "slot1")
            
            if lang == true {
                print("無事保存しました。アプリを終了します...")
            } else {
                print("saved successfuly. Terminate this App...")
            }
            exit(1)
        } else {
            
            if lang == true {
                print("ごめんなさい、そのポケモンは 現在使えません。アプリを終了します...")
            } else {
                print("Sorry, that Pokemon can't use on this App. Terminate this App...")
            }
            
            exit(1)
        }
    }
    

    // 3体のバトル選出画面
    class func launchPokemonSelectView() {
        
        func genderString(gender: Gender) -> String {
            
            switch gender {
            case .male:
                return "♂"
            case .female:
                return "♀"
            case .unknown:
                return ""
            case .null:
                return ""
            }
        }
        
        
        var myPokemon1IsSelected = ""
        var myPokemon2IsSelected = ""
        var myPokemon3IsSelected = ""
        var myPokemon4IsSelected = ""
        var myPokemon5IsSelected = ""
        var myPokemon6IsSelected = ""
        
        
        // これ、名前と条件が逆でくそわかりにくい。気をつけろ。
        var validlySelected = true
        
        // 1〜6が入る。1度選ばれたポケモンをもう1度選ぶことは断じて許さない
        var storedPokemonNo: [String] = []
        
        // "◯◯連勝中"を表示する定数
        let userDefaults = UserDefaults.standard
        
        var winCount: String {
         
            let win = userDefaults.integer(forKey: "winCount")
            
            if win < 2 {
                return ""
            }
            
            
            if lang == true {
                
                return "               ただいま \(win)連勝 ちゅう!"

            } else {
                return "               winning \(win) games in a row!!"
            }
        }
        
        
        
        // 3体選出するため、標準入力
        func selectPokemonFromStdIn() {
            
            
            
            for n in 0...2 {
                
                
                
                while validlySelected {
                    
                    ViewManipulation.clear()
                    ViewManipulation.moveCursorToOrigin()
                    
                    
                    print("")
                    print("【Enemy Pokemons】")
                    print("")
                    print("  - \(foePokemon1.name.makeSpace(str: foePokemon1.name)) Lv.50 \(genderString(gender: foePokemon1.gender)) ")
                    print("  - \(foePokemon2.name.makeSpace(str: foePokemon2.name)) Lv.50 \(genderString(gender: foePokemon2.gender)) ")
                    print("  - \(foePokemon3.name.makeSpace(str: foePokemon3.name)) Lv.50 \(genderString(gender: foePokemon3.gender)) ")
                    print("  - \(foePokemon4.name.makeSpace(str: foePokemon4.name)) Lv.50 \(genderString(gender: foePokemon4.gender)) ")
                    print("  - \(foePokemon5.name.makeSpace(str: foePokemon5.name)) Lv.50 \(genderString(gender: foePokemon5.gender)) ")
                    print("  - \(foePokemon6.name.makeSpace(str: foePokemon6.name)) Lv.50 \(genderString(gender: foePokemon6.gender)) ")
                    print("")
                    
                    print("【My Pokemons】", terminator: " ")
                    
//                    print("\u{1b}[5m", terminator: "") // 点滅
                    
                    print("\(winCount)")

//                    ViewManipulation.resetOutputColor()
                    
                    
                    
                    
                    ViewManipulation.resetOutputColor() // "◯◯連勝中!"
                    
                    print("")
                    
                    
                    print(" 1: \(myPokemon1.name.makeSpace(str: myPokemon1.name)) Lv.50 \(genderString(gender: myPokemon1.gender)) \(myPokemon1IsSelected)")
                    
                    print(" 2: \(myPokemon2.name.makeSpace(str: myPokemon2.name)) Lv.50 \(genderString(gender: myPokemon2.gender)) \(myPokemon2IsSelected)")
                    
                    print(" 3: \(myPokemon3.name.makeSpace(str: myPokemon3.name)) Lv.50 \(genderString(gender: myPokemon3.gender)) \(myPokemon3IsSelected) ")
                    
                    print(" 4: \(myPokemon4.name.makeSpace(str: myPokemon4.name)) Lv.50 \(genderString(gender: myPokemon4.gender)) \(myPokemon4IsSelected)")
                    
                    print(" 5: \(myPokemon5.name.makeSpace(str: myPokemon5.name)) Lv.50 \(genderString(gender: myPokemon5.gender)) \(myPokemon5IsSelected)")
                    
                    print(" 6: \(myPokemon6.name.makeSpace(str: myPokemon6.name)) Lv.50 \(genderString(gender: myPokemon6.gender)) \(myPokemon6IsSelected)")
                    
                    print("")
                    
                    
                    
                
                    print("\u{001B}[20;1H", terminator: "") // 20行目へ移動

                    print("\u{001B}[0J", terminator: "") // クリア

                    if lang == true {
                        print(" \(n+1)ばんての ポケモンは? ([1-6])")
                        print(" (半角数字で 指定してね)")
                        print("")
                    } else {
                        print(" What is your No.\(n+1) Pokemon? ([1-6])")
                        print(" (Designate by half-width number character)")
                        print("")
                    }
                    
                    let stdIn = FileHandle.standardInput
                    
                    let input = NSString(data:stdIn.availableData, encoding:String.Encoding.utf8.rawValue) ?? ""
                    
                    let scanner = Scanner(string:input as String).string
                    var inputArray:[String] = scanner.split()
                

                
                    // エンターで落ちる不都合の回避用
                    if inputArray.isEmpty {
                        
                        inputArray.append("unun")
    //                    print("なおしといた")
                    }
                    
                    
                    // 既に入ったポケモンが選択されたら、ここで食い止める
                    
                    if let first = inputArray.first {
                    
                        if storedPokemonNo.index(of: first) != nil {
                            
                            
                            if lang == true {
                                print(" その ポケモンは すでに えらばれて います。 ほかの ポケモンを えらんでね")
                            } else {
                                print(" That Pokemon's already selected. Select another Pokemon...")
                            }
                            
                            ViewManipulation.sleepForViewControl(interval: 1)
                            
                            continue
                        }
                        
                    }
                    
                    
                    
                    
                    // ここで "" だと ここで落ちてる。
                    switch inputArray.first! {
                        
                        case "1":
                            //selectedPokemonArray.append(repository.Pokemons[0])
                        //selectedPokemonArray.append(myPokemon1)
                            //selectedMyPokemonIndex.append(1)
                        
                        myPokemonArrayMainHas.append(myPokemon1)
                        
                        storedPokemonNo.append("1")
                        
                        myPokemon1IsSelected = "◯"
    
                        //                    print("よかよか 1だよ")
                        
                        validlySelected = false
                        
                        case "2":
                            //selectedPokemonArray.append(repository.Pokemons[1])
                        //selectedPokemonArray.append(myPokemon2)
                            //selectedMyPokemonIndex.append(2)
                        myPokemonArrayMainHas.append(myPokemon2)
                        
                        storedPokemonNo.append("2")
                        
                        myPokemon2IsSelected = "◯"


                        
    //                    print("よかよか 2だよ")
                        
                        validlySelected = false
                        
                        case "3":
                            //selectedPokemonArray.append(repository.Pokemons[2])
                        //selectedPokemonArray.append(myPokemon3)
                        //selectedMyPokemonIndex.append(3)
                            myPokemonArrayMainHas.append(myPokemon3)
                            
                            storedPokemonNo.append("3")
                            
                            myPokemon3IsSelected = "◯"


    //                        print("よかよか 3だよ")
                        
                            validlySelected = false

                        case "4":
                            //selectedPokemonArray.append(repository.Pokemons[3])
                        //selectedPokemonArray.append(myPokemon4)
                        //selectedMyPokemonIndex.append(4)
                            myPokemonArrayMainHas.append(myPokemon4)
                            
                            storedPokemonNo.append("4")
                            
                            myPokemon4IsSelected = "◯"


    //                        print("よかよか 4だよ")
                        
                            validlySelected = false

                        case "5":
                            //selectedPokemonArray.append(repository.Pokemons[4])
                        //selectedPokemonArray.append(myPokemon5)
                        //selectedMyPokemonIndex.append(5)
                            myPokemonArrayMainHas.append(myPokemon5)
                            
                            storedPokemonNo.append("5")
                            
                            myPokemon5IsSelected = "◯"


    //                        print("よかよか 5だよ")
                        
                            validlySelected = false

                        case "6":
                            //selectedPokemonArray.append(repository.Pokemons[5])
                        //selectedPokemonArray.append(myPokemon6)
                        //selectedMyPokemonIndex.append(6)
                            myPokemonArrayMainHas.append(myPokemon6)
                            
                            storedPokemonNo.append("6")
                            
                            myPokemon6IsSelected = "◯"


    //                        print("よかよか 6だよ")
                        
                            validlySelected = false

                        default:
                            //selectedPokemonArray.append(repository.Pokemons[0])
                            //selectedPokemonArray.append(myPokemon1)
                            
    //                        let tmpAry = [myPokemon1, myPokemon2, myPokemon3]
    //                        
    //                        myPokemonArrayMainHas.append(tmpAry[n])
    //                        print("想定外の入力。しょうがないから\(n+1)体目指定しといた")
                            
                            print("\u{001B}[23;1H", terminator: "")
                            
                            if lang == true {
                                print(" もういちど えらんでね...")
                            } else {
                                print(" not valid. Please select again...")
                            }
                            
                            ViewManipulation.sleepForViewControl(interval: 1)
                            
                        continue
                        
                    } // switch
                    
                } // while
                
                validlySelected = true
                
            } // end for
            
//             print("俺が選出したポケモンは、\(myPokemonArrayMainHas[0].name, myPokemonArrayMainHas[1].name, myPokemonArrayMainHas[2].name)です")
            
            
            
            /////
            
            ViewManipulation.clear()
            ViewManipulation.moveCursorToOrigin()
            
            print("")
            print("【Enemy Pokemons】")
            print("")
            print("  - \(foePokemon1.name.makeSpace(str: foePokemon1.name)) Lv.50 \(genderString(gender: foePokemon1.gender)) ")
            print("  - \(foePokemon2.name.makeSpace(str: foePokemon2.name)) Lv.50 \(genderString(gender: foePokemon2.gender)) ")
            print("  - \(foePokemon3.name.makeSpace(str: foePokemon3.name)) Lv.50 \(genderString(gender: foePokemon3.gender)) ")
            print("  - \(foePokemon4.name.makeSpace(str: foePokemon4.name)) Lv.50 \(genderString(gender: foePokemon4.gender)) ")
            print("  - \(foePokemon5.name.makeSpace(str: foePokemon5.name)) Lv.50 \(genderString(gender: foePokemon5.gender)) ")
            print("  - \(foePokemon6.name.makeSpace(str: foePokemon6.name)) Lv.50 \(genderString(gender: foePokemon6.gender)) ")
            print("")
            
            print("【My Pokemons】", terminator: " ")
            
            print("\(winCount)")
            
            print("")
            
            
            print(" 1: \(myPokemon1.name.makeSpace(str: myPokemon1.name)) Lv.50 \(genderString(gender: myPokemon1.gender)) \(myPokemon1IsSelected)")
            
            print(" 2: \(myPokemon2.name.makeSpace(str: myPokemon2.name)) Lv.50 \(genderString(gender: myPokemon2.gender)) \(myPokemon2IsSelected)")
            
            print(" 3: \(myPokemon3.name.makeSpace(str: myPokemon3.name)) Lv.50 \(genderString(gender: myPokemon3.gender)) \(myPokemon3IsSelected) ")
            
            print(" 4: \(myPokemon4.name.makeSpace(str: myPokemon4.name)) Lv.50 \(genderString(gender: myPokemon4.gender)) \(myPokemon4IsSelected)")
            
            print(" 5: \(myPokemon5.name.makeSpace(str: myPokemon5.name)) Lv.50 \(genderString(gender: myPokemon5.gender)) \(myPokemon5IsSelected)")
            
            print(" 6: \(myPokemon6.name.makeSpace(str: myPokemon6.name)) Lv.50 \(genderString(gender: myPokemon6.gender)) \(myPokemon6IsSelected)")
            
            print("")
            
            /////
            

            print("\u{001B}[20;1H", terminator: "")
            print("\u{001B}[0J", terminator: "")
            
            if lang == true {
                print(" せんたく かんりょう!")
            } else {
                print(" You've succeeded to select all Pokemons!")
            }
            
            ViewManipulation.sleepForViewControl(interval: 1.2)
            
            
        } // end of selectPokemonFromStdIn
        
        
        
        selectPokemonFromStdIn()
        
//        let input = NSString(data:stdIn.availableData, encoding:String.Encoding.utf8.rawValue) ?? "";
//        let scanner = Scanner(string:input as String).string;
//        let inputArray:[String] = scanner.split()
//        
//        if (inputArray.count > 0) {
//            command = Command.getFromInput(inputArray.first!) ?? Command.MOVE1
//            
//            if (inputArray.count > 1) {
//                data = Array(inputArray[1...inputArray.count - 1]);
//            } else {
//                data = [];
//                //print("コマンドには何の引数もついてない")
//            }
//        }
    }
    
    
//    class func launchShell() {
//
//        let task = Process()
//        task.launchPath = "/bin/bash"
//        // 絶対パスだけでなく、なんか相対パスでもいける
//        //task.arguments = ["-c","./TypeWriterOutput/TW.sh && ./TypeWriterOutput/View.sh"]
//        
//        //task.arguments = ["-c","/Users/masa/Desktop/TypeWriterOutput/TypeWriterOutput/TW.sh && /Users/masa/Desktop/TypeWriterOutput/TypeWriterOutput/View.sh"]
//        
//        
//        
//        /////////////////
//        // ↓　ここ、
//        // 第１引数に -c を指定すると、なぜか後続のコマンドライン引数をシェルスクリプトに渡せなくなるため、上ではなく下の方を使う。
//        
////        task.arguments = ["-c","/Users/masa/Desktop/TypeWriterOutput/TypeWriterOutput/TW.sh", "でんぱ組"]
//
//        
//        //let myPokeName = myBattlePokemon!.name
//        //let foePokeName = foeBattlePokemon!.name
//        
//        
//        //let battleMessageAry: [String] = ["doMove1", "husen", "nothing"]
//        //let battleMessageAry: [String] = ["doMove1", "foeDamage", "hitTwice", "husen"]
//        //let battleMessageAry: [String] = ["doMove1"]
//
//        
//        //task.arguments = ["/Users/masa/Desktop/TypeWriterOutput/TypeWriterOutput/TW.sh", "\(myPokeName)", "\(foePokeName)", "\(battleMessageAry)"]
//        
//        
//        
////        let pipe: Pipe = Pipe()
//        
//        //task.standardInput = FileHandle.nullDevice
//    
//        //task.standardError = FileHandle.standardError
//        //task.standardOutput = FileHandle.standardOutput
//        
//        //task.standardOutput = pipe
//        
//        //print("受け取ったコマンドライン引数は \(task.standardOutput)です")
//        
//        //task.standardInput = FileHandle.standardInput
//
//        task.launch()
//        task.waitUntilExit()
//    }
    
    
//    class func launchShell2(cmd: String, arguments args: [String], currentDirPath currentDir: String? = nil) -> String {
//        
//        
//        let task: Process = Process()
//        
//        task.launchPath = cmd
//        task.arguments = args
//        
//        if currentDir != nil {
//            task.currentDirectoryPath = currentDir!
//        }
//        
//        let pipe: Pipe = Pipe()
//        
//        task.standardOutput = pipe
//        task.launch()
//        
//        let out: NSData = pipe.fileHandleForReading.readDataToEndOfFile() as NSData
//        let outStr: String? = NSString(data: out as Data, encoding: String.Encoding.utf8.rawValue) as? String
//        return outStr == nil ? "" : outStr!
//    }
    
    
    
    
    
    class func launchShellFinal() {
        
//        print("")
//        print("-- ここからビュー --")
//        print("")
//        print("\(turn)ターン目 開始")
//        
//        print("敵 \(judge.battleField.foeBattlePokemon.name) Lv.50 \(judge.battleField.foeBattlePokemon.HP) / \(judge.battleField.foeBattlePokemon.MAXHP) \(judge.battleField.foeBattlePokemon.badStatus)")
//        
//        print("味方 \(judge.battleField.myBattlePokemon.name) Lv.50 \(judge.battleField.myBattlePokemon.HP) / \(judge.battleField.myBattlePokemon.MAXHP) \(judge.battleField.myBattlePokemon.badStatus)")
//        
//        print("")
//        print("-- ここまでビュー --")
        

    }
    
    class func launchPokemonChangeView() {
        
        var command: PokemonChangeSceneCommand = .choosePokemon1
        
        ViewManipulation.clear()
        ViewManipulation.moveCursorToOrigin()
        
        
        // ここ！！！注意しろ！！！
        if judge.battleField.myBattlePokemon.HP <= 0 {
            print("\u{1b}[31m", terminator: "")
        }

        
        // ここ！ 追記！！
//        myBVC.renewBIW(howToActivate: .currentBF)
        
        myBVC.renewBIW(howToActivate: .tmpBF)
        

        judge.storeValueToTmpVar()
        
        myBVC.outputBattleInfoWindow()
        
        print("")
        
        
        if lang == true {
            print(" どの ポケモンに かえますか? ([1-3/q])")
        } else {
            print(" Select new Pokemon. ([1-3/q])")
        }
        
        
        print("")

        
        
        
        var idx = 1

        
        for x in (judge.battleField.myParty) {
            
            
            var name = x.name
            var HP = x.HP.description
            var MAXHP = x.MAXHP.description

            let gender = { () -> String in
                
                // これ、キャプチャになってない？メモリリーク大丈夫？
                switch x.gender {
                    
                    case .male:
                        return "♂"
                    
                    case .female:
                        return "♀"
                    
                    case .unknown:
                        return " "
                    
                    default:
                        return " "
                }
                    
                    
            }
            
            
            var asterisk = " "
            
            if x == judge.battleField.myBattlePokemon {
                asterisk = "*"
            }
            
            
            if x.HP <= 0 {
                print("\u{1b}[31m", terminator: "")
            } else {
                ViewManipulation.resetOutputColor()
            }

            
            // 日本語の場合
            if lang == true {
                
                if name.characters.count < 6 {
                    
                    let shortage = 6 - name.characters.count
                    
                    for _ in 1...shortage {
                        name += "  "
                    }
                }
                
                
            } else {  // 英語の場合
            
                if name.characters.count < 10 {
                    
                    let shortage = 10 - name.characters.count
                    
                    for _ in 1...shortage {
                        name += " "
                    }
                }
                
            }
            
            
            if HP.characters.count < 3 {
                
                let shortage = 3 - HP.characters.count

                var emptyStr = ""

                for _ in 1...shortage {
                    emptyStr += " "
                }
                
                HP = emptyStr + HP
                
            }
            
            if MAXHP.characters.count < 3 {
                
                let shortage = 3 - MAXHP.characters.count
                
                var emptyStr = ""
                
                for _ in 1...shortage {
                    emptyStr += " "
                }
                
                MAXHP = emptyStr + MAXHP
                
            }

            
            print(asterisk, terminator: "") // 現在のポケモンには * がつく
            
            let str1 = "\(idx): "
            print(str1, terminator: "")
            
            let str2 = name
            print(str2, terminator: "")
            
            print(" ", terminator: "")
            
            print("Lv.50", terminator: "")
            
            print(" ", terminator: "")
            
            print("\(gender()) HP", terminator: "")
            
            print(" ", terminator: "")
            
            print("\(HP)", terminator: "")
            
            print(" ", terminator: "")
            
            print("/", terminator: "")
            
            print(" ", terminator: "")
            
            print("\(MAXHP)", terminator: "")
            
            print(" ", terminator: "")
            
            print("\(x.badStatus.rawValue)")


//            let myPartyString: String = " \(idx): \(x.name) Lv.\(x.lv) \(x.HP) / \(x.MAXHP) \(x.badStatus)"
//            print(myPartyString)
            idx += 1
            
            ViewManipulation.resetOutputColor()
        }
        
        if judge.battleField.myBattlePokemon.HP > 0 {
            print("")
            
            if lang == true {
                print(" q: もどる")
            } else {
                print(" q: Quit")
            }
        }
        
        print("")
        
        
        let stdIn = FileHandle.standardInput
        
        let input = NSString(data:stdIn.availableData, encoding:String.Encoding.utf8.rawValue) ?? "";
        
        
        //print("1:お前の \(input)を出したいという願い　たしかに　受け取った")
        
        let scanner = Scanner(string:input as String).string;
        
        //print("2:お前の \(scanner)を出したいという願い　たしかに　受け取った")
        
        var inputArray:[String] = scanner.split()
        
//        print("3:お前の \(inputArray)を出したいという願い　たしかに　受け取った")
        
        
 
        // エンターで1体目のポケモンが選ばれる不都合の回避用
        if inputArray.isEmpty {
            
            inputArray.append("error")
            //  print("なおしといた")
        }
        
        
        if (inputArray.count > 0) {
            
            command = PokemonChangeSceneCommand.getFromInput(inputArray.first!) ?? PokemonChangeSceneCommand.quit
            // 想定外のコマンドが入力された際の挙動を変えたいときは、この ?? 以降を変えればよいってわけか。
                // と思いきや、きかず、なぜか 「1番目のポケモンを選択」したのとおなじになる。だめじゃこりゃ。
            
                // 違う。正確には、「前のターンで入力したコマンドが残っている」。
                // つまり、前のターンでわざ1を選んでいた場合、ここでエンターを入力すると「ポケモン1を選択」したのとおなじになる。やばい。
            
            if (inputArray.count > 1) {
                data = Array(inputArray[1...inputArray.count - 1]);
            } else {
                data = [];
                //print("コマンドには何の引数もついてない")
            }
        }
        
        switch command {
            
        case .choosePokemon1:
            //                judge.initiateTurnProcess(moveNo: 1)
//            print("1番目の ポケモンが 交換先に 指定された！")
            judge.pokemonChangeImplement(changeTo: 0)
        case .choosePokemon2:
            //                judge.initiateTurnProcess(moveNo: 2)
//            print("2番目の ポケモンが 交換先に 指定された！")
            judge.pokemonChangeImplement(changeTo: 1)
        case .choosePokemon3:
            //                judge.initiateTurnProcess(moveNo: 3)
//            print("3番目の ポケモンが 交換先に 指定された！")
            judge.pokemonChangeImplement(changeTo: 2)
        case .quit:
//            print("キャンセル")
            quit = true
            
        }

    }  // end of launchPokemonChangeView()
    
    
    
    // わざ入力 / 待機画面で表示されるバトル・インフォ
    
    class func launchConditionView(BF: BattleField) -> String {
        
        
        // 『画面』そのもの
        var conditionView: String = ""
        
        // ターン数
        var turnForDisplay = (turn + 1).description
        
        let myPokeName1 = BF.myPokemon1.name
        let myPokeName2 = BF.myPokemon2.name
        let myPokeName3 = BF.myPokemon3.name
        
        let myPokeNameAry = [myPokeName1, myPokeName2, myPokeName3]
        
        let foePokeName1 = BF.foePokemon1.name
        let foePokeName2 = BF.foePokemon2.name
        let foePokeName3 = BF.foePokemon3.name
        
        let foePokeNameAry = [foePokeName1, foePokeName2, foePokeName3]

        let weatherUnicodeAry = ["⛅"]
        
        // ターン数の文字数調整
        if turnForDisplay.characters.count < 3 {
            
            let shortage = 3 - turnForDisplay.characters.count
            
            for _ in 1...shortage {
                turnForDisplay += " "
            }
        }
        
        
        
        var myPokeNameForDisp = BF.myBattlePokemon.name
        
        
        // 味方のポケモン名の文字数調整
//        for var eachPokeName in myPokeNameAry {
        
        
        // 日本語の場合
        if lang == true {
            
            if myPokeNameForDisp.characters.count < 6 {
                
                let shortage = 6 - myPokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    myPokeNameForDisp += "  "
                }
            }
        
        // 英語の場合
        } else {
        
            if myPokeNameForDisp.characters.count < 10 {
                    
                let shortage = 10 - myPokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    myPokeNameForDisp += " "
                }
            }
        }
        
//        }
        
        
        var foePokeNameForDisp = BF.foeBattlePokemon.name

        
        // 敵のポケモン名の文字数調整
//        for var eachPokeName in foePokeNameAry {
        
        // 日本語の場合
        if lang == true {
        
            if foePokeNameForDisp.characters.count < 6 {
                
                let shortage = 6 - foePokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    foePokeNameForDisp += "  "
                }
            }
        
        // 英語の場合
        } else {
            
            if foePokeNameForDisp.characters.count < 10 {
                
                let shortage = 10 - foePokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    foePokeNameForDisp += " "
                }
            }
            
            
            
        }
            
            
            
            
//        }
        
        
        ViewManipulation.clear()
        ViewManipulation.moveCursorToOrigin()
            
        // 40列目が[=]となっている
        
        
        // 自分の残りポケモン数を表示
        var myRestPokemonCount: String {
            
            var KOcount = 0
            
            for x in judge.battleField.myParty {
                
                if x.HP <= 0 {
                    KOcount += 1
                }
            }
            
            switch KOcount {
            case 0:
                return "◯ ◯ ◯"
            case 1:
                return "◯ ◯"
            case 2:
                return "◯"
            default:
                return " "
            }
        }
        
        
        // 敵の残りポケモン数を表示
        var foeRestPokemonCount: String {
            
            var KOcount = 0
            
            for x in judge.battleField.foeParty {
                
                if x.HP <= 0 {
                    KOcount += 1
                }
            }
            
            switch KOcount {
            case 0:
                return "◯ ◯ ◯"
            case 1:
                return "◯ ◯"
            case 2:
                return "◯"
            default:
                return " "
            }
        }
        
        
        
        
        
        conditionView =
        
        " ------------------------------------------------------------------------------ \n"  + // 1
        "                                                                               \n" +  // 2
        "   Turn \(turnForDisplay) \(weatherUnicodeAry[0])                              \n" +  // 3
        "   \(foeRestPokemonCount)                                                      \n" + //4
        "   \(foePokeNameForDisp) Lv.50 \(BF.foeBattlePokemon.badStatus.rawValue)       \n" +  // 5
        "                                                                               \n" +  // 6
        "   HP   \(BF.foeBattlePokemon.HP) / \(BF.foeBattlePokemon.MAXHP)               \n" +  // 7
        "                                                                               \n" +  // 8
        "   \(myPokeNameForDisp) Lv.50 \(BF.myBattlePokemon.badStatus.rawValue)         \n" +  // 9
        "                                                                               \n" +  // 10
        "   HP   \(BF.myBattlePokemon.HP) / \(BF.myBattlePokemon.MAXHP)                 \n" +  // 11
        "   \(myRestPokemonCount)                                                       \n" + //12
        " ------------------------------------------------------------------------------ \n"  // 13

        // ↑の13行目にも\nを書かないと、13行目にカーソルが位置したままなのでちらついてしまう。\n強制的にカーソルを下の行に移動すれば防止可。
        
        return conditionView
        
    } // end of launchConditionView()


    // わざが実行中に、バトルメッセージとともに表示されるバトル・インフォ
    
    class func launchConditionView2() -> String {
        
//        var tmp_Turn = 0
//        
//        var tmp_myPokemonRestCount = 0
//        var tmp_foePokemonRestCount = 0
//        
//        var tmp_myPokemonHP = 0
//        var tmp_myPokemonMAXHP = 0
//        var tmp_myPokemonLv = 0
//        var tmp_myPokemonBadStatus: BadStatus = .null
//        
//        var tmp_foePokemonHP = 0
//        var tmp_foePokemonMAXHP = 0
//        var tmp_foePokemonLv = 0
//        var tmp_foePokemonBadStatus: BadStatus = .null
        
        
        let weatherUnicodeAry = ["⛅"]
        
        
        
        // 『画面』そのもの
        var conditionView: String = ""
        
        // ターン数
        var turnForDisplay = judge.tmp_Turn.description
        

        // ターン数の文字数調整
        if turnForDisplay.characters.count < 3 {
            
            let shortage = 3 - turnForDisplay.characters.count
            
            for _ in 1...shortage {
                turnForDisplay += " "
            }
        }
        
        // 味方のポケモン名の文字数調整
        
        // 日本語の場合
        if lang == true {
        
            if judge.tmp_myPokemonName.characters.count < 6 {
                    
                let shortage = 6 - judge.tmp_myPokemonName.characters.count
                    
                for _ in 1...shortage {
                    judge.tmp_myPokemonName += "  "
                }
            }
        
        // 英語の場合
        } else {
            
            if judge.tmp_myPokemonName.characters.count < 10 {
                
                let shortage = 10 - judge.tmp_myPokemonName.characters.count
                
                for _ in 1...shortage {
                    judge.tmp_myPokemonName += " "
                }
            }
        }
            
            
            
        // 敵のポケモン名の文字数調整
        
        if lang == true {
            
            if judge.tmp_foePokemonName.characters.count < 6 {
                
                let shortage = 6 - judge.tmp_foePokemonName.characters.count
                
                for _ in 1...shortage {
                    judge.tmp_foePokemonName += "  "
                }
            }
            
        } else {
            
            if judge.tmp_foePokemonName.characters.count < 10 {
                
                let shortage = 10 - judge.tmp_foePokemonName.characters.count
                
                for _ in 1...shortage {
                    judge.tmp_foePokemonName += " "
                }
            }
        }
        
        
        // 自分の残りポケモン数を表示
        var myRestPokemonCount: String {
            
            switch judge.tmp_myPokemonRestCount {
                
                case 0:
                    return " "
                case 1:
                    return "◯"
                case 2:
                    return "◯ ◯"
                case 3:
                    return "◯ ◯ ◯"
                default:
                    return ""
            }
        }
        
        
        // 敵の残りポケモン数を表示
        var foeRestPokemonCount: String {

            switch judge.tmp_foePokemonRestCount {
                
                case 0:
                    return " "
                case 1:
                    return "◯"
                case 2:
                    return "◯ ◯"
                case 3:
                    return "◯ ◯ ◯"
                default:
                    return ""
            }
        }
        
        
        ViewManipulation.clear()
        ViewManipulation.moveCursorToOrigin()
        
        
        conditionView =
            
            " --------------------------------------=--------------------------------------- \n" +  // 1
            "   \n" +  // 2
            "   Turn \(turnForDisplay) \(weatherUnicodeAry[0]) \n" +  // 3
            "   \(foeRestPokemonCount) \n" + //4
            "   \(judge.tmp_foePokemonName) Lv.50 \(judge.tmp_foePokemonBadStatus.rawValue)     \n" +  // 5
            "   \n" +  // 6
            "   HP   \(judge.tmp_foePokemonHP) / \(judge.tmp_foePokemonMAXHP)     \n" +  // 7
            "   \n" +  // 8
            "   \(judge.tmp_myPokemonName) Lv.50 \(judge.tmp_myPokemonBadStatus.rawValue)     \n" +  // 9
            "   \n" +  // 10
            "   HP   \(judge.tmp_myPokemonHP) / \(judge.tmp_myPokemonMAXHP)     \n" +  // 11
            "   \(myRestPokemonCount) \n" + //12
            " --------------------------------------=--------------------------------------- \n"  // 13
        
        // ↑の13行目にも\nを書かないと、13行目にカーソルが位置したままなのでちらついてしまう。\n強制的にカーソルを下の行に移動すれば防止可。
        
        return conditionView
    }
    
    
    // c を指定すると表示される、アナライズ画面
    
    class func launchAnalyzeView(BF: BattleField) -> String {
        
        let weatherUnicodeAry = ["⛅"]
        
        let statsChangeUnicodeAry = ["☠", "💋", "🌀", "👻", "😪", "😱"]

        
        
        var myPokeStats: String {
            
            var ary: String = ""
            
            for eachSC in judge.battleField.myBattlePokemon.statusChange {
                
                switch eachSC {
                    
                    case .destinyBond:
                        ary += statsChangeUnicodeAry[3]
                    case .yawn:
                        ary += statsChangeUnicodeAry[4]
                    default:
                        continue
                }
            }
            
            return ary
        }
        
        var foePokeStats: String {
            
            var ary: String = ""
            
            for eachSC in judge.battleField.foeBattlePokemon.statusChange {
                
                switch eachSC {
                    
                case .destinyBond:
                    ary += statsChangeUnicodeAry[3]
                case .yawn:
                    ary += statsChangeUnicodeAry[4]
                default:
                    continue
                }
            }
            
            return ary
        }
        
        
        
        
        
        var turnForDisplay = (turn + 1).description
        
        ViewManipulation.clear()
        ViewManipulation.moveCursorToOrigin()
        
        
        var myPokeNameForDisp = BF.myBattlePokemon.name
        var foePokeNameForDisp = BF.foeBattlePokemon.name

        let analyzeViewString: String
        
        // ターン数の文字数調整
        if turnForDisplay.characters.count < 3 {
            
            let shortage = 3 - turnForDisplay.characters.count
            
            for _ in 1...shortage {
                turnForDisplay += " "
            }
        }
        
        
        // 味方のポケモン名の文字数調整
        
        if lang == true {
        
            if myPokeNameForDisp.characters.count < 6 {
                
                let shortage = 6 - myPokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    myPokeNameForDisp += "  "
                }
            }
            
        } else {
            
            if myPokeNameForDisp.characters.count < 10 {
                
                let shortage = 10 - myPokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    myPokeNameForDisp += " "
                }
            }
        }
        
        
        // 敵のポケモン名の文字数調整
        
        if lang == true {
            
            if foePokeNameForDisp.characters.count < 6 {
                
                let shortage = 6 - foePokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    foePokeNameForDisp += "  "
                }
            }
            
        } else {

            if foePokeNameForDisp.characters.count < 10 {
                
                let shortage = 10 - foePokeNameForDisp.characters.count
                
                for _ in 1...shortage {
                    foePokeNameForDisp += " "
                }
            }
        }
        
        
        let myPokeAtkLvForDisp = BF.myBattlePokemon.buffDebuff.atkLv.description
        let myPokeDefLvForDisp = BF.myBattlePokemon.buffDebuff.defLv.description
        let myPokeS_AtkLvForDisp = BF.myBattlePokemon.buffDebuff.s_atkLv.description
        let myPokeS_DefLvForDisp = BF.myBattlePokemon.buffDebuff.s_defLv.description
        let myPokeSpdLvForDisp = BF.myBattlePokemon.buffDebuff.speedLv.description
        
        let foePokeAtkLvForDisp = BF.foeBattlePokemon.buffDebuff.atkLv.description
        let foePokeDefLvForDisp = BF.foeBattlePokemon.buffDebuff.defLv.description
        let foePokeS_AtkLvForDisp = BF.foeBattlePokemon.buffDebuff.s_atkLv.description
        let foePokeS_DefLvForDisp = BF.foeBattlePokemon.buffDebuff.s_defLv.description
        let foePokeSpdLvForDisp = BF.foeBattlePokemon.buffDebuff.speedLv.description
        
        
        var myPokeBuffAryForDisp = [myPokeAtkLvForDisp,myPokeDefLvForDisp,myPokeS_AtkLvForDisp,myPokeS_DefLvForDisp,myPokeSpdLvForDisp]
        
        var foePokeBuffAryForDisp = [foePokeAtkLvForDisp,foePokeDefLvForDisp,foePokeS_AtkLvForDisp,foePokeS_DefLvForDisp,foePokeSpdLvForDisp]
        
        // 味方のバフレベルの文字空白調節
        var myAryIdx = 0
        
        for each in myPokeBuffAryForDisp {
            
            if each.characters.count < 2 {
                myPokeBuffAryForDisp[myAryIdx] = " " + each
            }
            
            myAryIdx += 1
        }
        
        // 敵のバフレベルの文字空白調節
        var foeAryIdx = 0
        
        for each in foePokeBuffAryForDisp {
            
            if each.characters.count < 2 {
                foePokeBuffAryForDisp[foeAryIdx] = " " + each
            }
            
            foeAryIdx += 1
        }
        

        analyzeViewString =
        
            "\n" +
            "\n" +
            "   Turn \(turnForDisplay) \(weatherUnicodeAry[0]) \n" +
            "\n" +
            "   \(foePokeNameForDisp) ATK: \(foePokeBuffAryForDisp[0]) DEF: \(foePokeBuffAryForDisp[1]) sATK: \(foePokeBuffAryForDisp[2]) sDEF: \(foePokeBuffAryForDisp[3]) SPD: \(foePokeBuffAryForDisp[4]) \(foePokeStats)\n" +
            "\n" +
            "\n" +
            "\n" +
            "   \(myPokeNameForDisp) ATK: \(myPokeBuffAryForDisp[0]) DEF: \(myPokeBuffAryForDisp[1]) sATK: \(myPokeBuffAryForDisp[2]) sDEF: \(myPokeBuffAryForDisp[3]) SPD: \(myPokeBuffAryForDisp[4]) \(myPokeStats)\n" +
            "\n" +
            "\n" +
            "\n" +
            "\n" // 13
        
        return analyzeViewString
    }

}  // このファイルの終了


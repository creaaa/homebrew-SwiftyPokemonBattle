
import Foundation


extension Bool {
    
    var myselfInt: Int {
        
        if self == true {
            return 0
        } else {
            return 1
        }
    }
    
    var myselfHantenInt: Int {
        
        if self == true {
            return 1
        } else {
            return 0
        }
    }
}



// バフ・デバフの構造体
struct BuffStruct {
    
    let buffAry =   [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
    let debuffAry = [1.0, 0.66, 0.5, 0.4, 0.33, 0.29, 0.25]
    
    
    // MARK: - 各ステータスのバフ/デバフLv
    var atkLv: Int = 0 {
        
        didSet {
            
            // ±6 より上 / 未満は、強制的に±6に再設定
            if self.atkLv > 6 {
                self.atkLv = 6
            } else if self.atkLv < -6 {
                self.atkLv = -6
            }
            
            
            // ポケモンチェンジ時は、以下が発動しないようにしたい。これでいいのか？
            // だめだ。強制チェンジ時に対応できない
//            if  command == .CHANGE_POKEMON || judge.foeAction == 5 {
//                
//                return
//            }
            
            // そのとき 天啓 走る！ポケモンチェンジ時には強制的に 0がセットされる = このときreturnすればよい
            if (oldValue != -2 || oldValue != -1 || oldValue == 0 || oldValue != 1 || oldValue != 2) && atkLv == 0 {
                return
            }
            
            
            // うおー　めんどい。。
            let pokeStorage = [judge.battleField.myBattlePokemon, judge.battleField.foeBattlePokemon]
            
//            var idx = 0
//            
//            if let tgt = judge.addTargetTo {
//                
//                idx = tgt ? 0 : 1
//            }
//            
//            if pokeStorage[idx].HP <= 0 {
//                return
//            }
            
            
            
            if let tgt = judge.addTargetTo {
                
                switch tgt {
                    
                case true:
                    
                    if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                    
                case false:
                    
                    if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                }
            }
            
            
            
            
            // こんな感じで　できるはず
            var target = ""
            
            if let tgt = judge.addTargetTo {
                
                switch judge.whoIsTurn {
                
                    // 今、自分のターンのとき
                    case true:
                    
                        switch tgt {
                            case true:
                                
                                if lang == true {
                                    target = "\(judge.battleField.myBattlePokemon.name)の\n"
                                } else {
                                    target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                                }
                            
                            case false:
                                if lang == true {
                                    target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                                } else {
                                    target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                                }
                        }
                    
                    // 今、相手のターンのとき
                        case false:
                        
                            switch tgt {
                                
                                case true:
                                    if lang == true {
                                        target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                                    } else {
                                        target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                                    }
                                case false:
                                    if lang == true {
                                        target = "\(judge.battleField.myBattlePokemon.name)の\n"
                                    } else {
                                        target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                                    }
                            }
                }
            }
                
                
                
                
//                switch tgt {
//                case true:
//                    target = "\(judge.battleField.myBattlePokemon.name)の\n"
//                case false:
//                    target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
//                }
//            }
            
            
            if atkLv == oldValue + 2 || (atkLv == 6 && oldValue == 5) {
                
//                print("\(target)の こうげきが\nぐーんと あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)こうげきが ぐーんと あがった!   ")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)ATTACK sharply rose!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if atkLv == oldValue + 1 {
                
//                print("こうげきが あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)こうげきが あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)ATTACK rose!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if atkLv == oldValue - 1 {
                
//                print("こうげきが さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)こうげきが さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)ATTACK fell!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
            }
            
            else if atkLv == oldValue - 2 || (atkLv == -6 && oldValue == -5) {
                
//                print("こうげきが がくっと さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)こうげきが がくっと さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)ATTACK sharply fell!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            // これおかしい。死んで強制チェンジ時に発動するし、、
//            if atkLv == oldValue {
//                
//                print("こうげきは もう かわらない！")
//                
//                myBVC.enqueue(reveivedStr: "こうげきは もう かわらない！")
//                myBVC.outputBattleMessageLikeTypeWriter()
//                judge.storeValueToTmpVar()
//            }

        }
    }
    
    
    var defLv: Int = 0 {
        didSet {
            
            if self.defLv > 6 {
                self.defLv = 6
            } else if self.defLv < -6 {
                self.defLv = -6
            }
            
            
            // ポケモンチェンジ時は、以下が発動しないようにしたい。これでいいのか？
            // だめだ。強制チェンジ時に対応できない
//            if  command == .CHANGE_POKEMON || judge.foeAction == 5 {
//                
//                return
//            }
            
            // そのとき 天啓 走る！ポケモンチェンジ時には強制的に 0がセットされる = このときreturnすればよい
            if (oldValue != -2 || oldValue != -1 || oldValue == 0 || oldValue != 1 || oldValue != 2) && defLv == 0 {
                return
            }
            
            
            // うおー　めんどい。。
            let pokeStorage = [judge.battleField.myBattlePokemon, judge.battleField.foeBattlePokemon]
//            
//            var idx = 0
//            
//            if let tgt = judge.addTargetTo {
//                
//                idx = tgt ? 0 : 1
//            }
//            
//            if pokeStorage[idx].HP <= 0 {
//                return
//            }

            
            if let tgt = judge.addTargetTo {
                
                switch tgt {
                    
                case true:
        
        // 最後の　pokeStorage[judge.whoIsTurn.myselfInt].HP <= 0　は、「インファイトをうった」→「みちづれされた」ときにありえる
        if (judge.moveName == "Close Combat") && (pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 || pokeStorage[judge.whoIsTurn.myselfInt].HP <= 0) {
//                        print("hoge--")
            
                    // 11/11 21:50 スコープ内に何も書いてなかったのを、 return に変更。
                    // やばくなったら　もどす
            
                    return
            
                    }
                    else if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                    
                case false:
                    

                    if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                }
            }
            

            // こんな感じで　できるはず
            var target = ""
            
            if let tgt = judge.addTargetTo {
                
                switch judge.whoIsTurn {
                    
                // 今、自分のターンのとき
                case true:
                    
                    switch tgt {
                        
                    case true:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                    case false:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposing \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                    }
                    
                // 今、相手のターンのとき
                case false:
                    
                    switch tgt {
                        
                    case true:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                    case false:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                    }
                }
            }
            
            
            if defLv == oldValue + 2 || (defLv == 6 && oldValue == 5) {
                
//                print("ぼうぎょが ぐーんと あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)ぼうぎょが ぐーんと あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)DEFFENSE sharply rose!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if defLv == oldValue + 1 {
                
//                print("ぼうぎょが あがった！")
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)ぼうぎょが あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)DEFFENSE rose!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if defLv == oldValue - 1 {
                
//                print("ぼうぎょが さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)ぼうぎょが さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)DEFFENSE fell!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
            }
            
            else if defLv == oldValue - 2 || (defLv == -6 && oldValue == -5) {
                
//                print("ぼうぎょが がくっと さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)ぼうぎょが がくっと さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)DEFFENSE sharply fell!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
        }
    }
    
    
    var s_atkLv: Int = 0 {
        
        didSet {
            if self.s_atkLv > 6 {
                self.s_atkLv = 6
            } else if self.s_atkLv < -6 {
                self.s_atkLv = -6
            }

            
            // ポケモンチェンジ時は、以下が発動しないようにしたい。これでいいのか？
            // だめだ。強制チェンジ時に対応できない
//            if  command == .CHANGE_POKEMON || judge.foeAction == 5 {
//                
//                return
//            }
            
            // そのとき 天啓 走る！ポケモンチェンジ時には強制的に 0がセットされる = このときreturnすればよい
            if (oldValue != -2 || oldValue != -1 || oldValue == 0 || oldValue != 1 || oldValue != 2) && s_atkLv == 0 {
                return
            }
            
            
            // うおー　めんどい。。
            let pokeStorage = [judge.battleField.myBattlePokemon, judge.battleField.foeBattlePokemon]
            
//            var idx = 0
//            
//            if let tgt = judge.addTargetTo {
//                
//                idx = tgt ? 0 : 1
//            }
            
            
            
            // リーフストーム・りゅうせいぐん・インファイトは、ここでおかしくなってる。よって、↓のようにした
//            if pokeStorage[idx].HP <= 0 {
//                return
//            }

            
            ////////////////////////////////////////////////////////////////////
            
            
            
            // りゅうせいぐんの場合、こっちのスコープをヒットさせて、↓のスコープは無視させる。
            // これで完成。だが永すぎるのでさすがに他のやつ考えろ
            
//            if (judge.whoIsTurn == false) && judge.battleField.foeBattlePokemon.moveArray[judge.foeAction-1].name == "Draco Meteor" || judge.battleField.foeBattlePokemon.moveArray[judge.foeAction-1].name == "Leaf Storm" {
//                // 何も書かない
//                print("やっときた")
//            }
                
            // ふつうのわざの場合はこちら。
            
            // 今、こちらのターンの場合 : 「相手のHPが0以下の場合」
            // 今、相手のターンの場合 :   「味方のHPが0以下の場合」
//            else if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
//                return
//            }

            
            ////////////////////////////////////////////////////////////////////
            
            if let tgt = judge.addTargetTo {
            
                switch tgt {
                
                case true:
                    
                    
                    // この 最後の「pokeStorage[judge.whoIsTurn.myselfInt].HP <= 0」なんてありあるのか？
                    // 実はあるんだな、これが、「りゅうせいぐんをうった→みちづれされた」とき、これに該当する。
                    
                    
                    if (judge.moveName == "Draco Meteor" || judge.moveName == "Leaf Storm") && (pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 || pokeStorage[judge.whoIsTurn.myselfInt].HP <= 0) {
                        
                        // 11/11 21:50 スコープ内に何も書いてなかったのを、 return に変更。
                        // やばくなったら　もどす
                        return
                    }
                        
                    else if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                
                case false:


                     if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                }
            }
                
                
                
                
            
            
            // こんな感じで　できるはず
            var target = ""
            
            if let tgt = judge.addTargetTo {
                
                switch judge.whoIsTurn {
                    
                // 今、自分のターンのとき
                case true:
                    
                    switch tgt {
                    case true:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                        
                    case false:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                    }
                    
                // 今、相手のターンのとき
                case false:
                    
                    switch tgt {
                        
                    case true:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                    case false:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                    }
                }
            }
            
            
            if s_atkLv == oldValue + 2 || (s_atkLv == 6 && oldValue == 5) {
                
//                print("とくこうが ぐーんと あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくこうが ぐーんと あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_ATTACK sharply rose!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if s_atkLv == oldValue + 1 {
                
//                print("とくこうが あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくこうが あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_ATTACK rose!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if s_atkLv == oldValue - 1 {
                
//                print("とくこうが さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくこうが さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_ATTACK fell!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                
                
                judge.storeValueToTmpVar()
            }
            
            else if s_atkLv == oldValue - 2 || (s_atkLv == -6 && oldValue == -5) {
                
//                print("とくこうが がくっと さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくこうが がくっと さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_ATTACK sharply fell!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
        }
    }
    
    
    var s_defLv: Int = 0 {
        
        didSet {
            
            if self.s_defLv > 6 {
                self.s_defLv = 6
            } else if self.s_defLv < -6 {
                self.s_defLv = -6
            }
            
            
            // ポケモンチェンジ時は、以下が発動しないようにしたい。これでいいのか？
            // だめだ。強制チェンジ時に対応できない
//            if  command == .CHANGE_POKEMON || judge.foeAction == 5 {
//                
//                return
//            }
            
            // そのとき 天啓 走る！ポケモンチェンジ時には強制的に 0がセットされる = このときreturnすればよい
            if (oldValue != -2 || oldValue != -1 || oldValue != 1 || oldValue == 0 || oldValue != 2) && s_defLv == 0 {
                return
            }
            
            
            // うおー　めんどい。。
            let pokeStorage = [judge.battleField.myBattlePokemon, judge.battleField.foeBattlePokemon]
            
//            var idx = 0
//            
//            if let tgt = judge.addTargetTo {
//                
//                idx = tgt ? 0 : 1
//            }
//            
//            if pokeStorage[idx].HP <= 0 {
//                return
//            }
            
            
            
            if let tgt = judge.addTargetTo {
                
                switch tgt {
                    
                case true:
                    
                    // 最後は　インファイト→道連れされたら、該当する
                    if (judge.moveName == "Close Combat") && (pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 || pokeStorage[judge.whoIsTurn.myselfInt].HP <= 0) {

                        // 11/11 21:50 スコープ内に何も書いてなかったのを、 return に変更。
                        // やばくなったら　もどす
                        return
                        
                    }
                    else if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                    
                case false:
                    
                    if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                }
            }
            
            
            
            
            // こんな感じで　できるはず
            var target = ""
            
            if let tgt = judge.addTargetTo {
                
                switch judge.whoIsTurn {
                    
                // 今、自分のターンのとき
                case true:
                    
                    switch tgt {
                    case true:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                    case false:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                        
                    }
                    
                // 今、相手のターンのとき
                case false:
                    
                    switch tgt {
                        
                    case true:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                    case false:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                    }
                }
            }

            
            if s_defLv == oldValue + 2 || (s_defLv == 6 && oldValue == 5) {
                
//                print("とくぼうが ぐーんと あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくぼうが ぐーんと あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_DEFFENSE sharply rose!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if s_defLv == oldValue + 1 {
                
//                print("とくぼうが あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくぼうが あがった！")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_DEFFENSE rose!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if s_defLv == oldValue - 1 {
                
//                print("とくぼうが さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくぼうが さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_DEFFENSE fell!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
            }
            
            else if s_defLv == oldValue - 2 || (s_defLv == -6 && oldValue == -5) {
                
//                print("とくぼうが がくっと さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)とくぼうが がくっと さがった！")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)S_DEFFENSE sharply fell!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
        }
    }
    
    
    var speedLv: Int = 0 {
        
        didSet {
            
            if self.speedLv > 6 {
                self.speedLv = 6
            } else if self.speedLv < -6 {
                self.speedLv = -6
            }
            
            
            
            
            // ポケモンチェンジ時は、以下が発動しないようにしたい。これでいいのか？
            // だめだ。強制チェンジ時に対応できない
//            if  command == .CHANGE_POKEMON || judge.foeAction == 5 {
//                
//                return
//            }
            
            
            // そのとき 天啓 走る！ポケモンチェンジ時には強制的に 0がセットされる = このときreturnすればよい
            if (oldValue != -2 || oldValue != -1 || oldValue == 0 || oldValue != 1 || oldValue != 2) && speedLv == 0 {
                return
            }
            
            // うおー　HP0のときはメッセージを出力させないための処理だ。。
            let pokeStorage = [judge.battleField.myBattlePokemon, judge.battleField.foeBattlePokemon]
            
//            var idx = 0
            
//            if let tgt = judge.addTargetTo {
//                
//                idx = tgt ? 0 : 1
//            }

            
            
            if let tgt = judge.addTargetTo {
                
                switch tgt {
                    
                case true:
                    
                    if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                    
                case false:
                    
                    if pokeStorage[judge.whoIsTurn.myselfHantenInt].HP <= 0 {
                        return
                    }
                }
            }
            
            
            
            
            // こんな感じで　できるはず
            var target = ""
            
            if let tgt = judge.addTargetTo {
                
                switch judge.whoIsTurn {
                    
                // 今、自分のターンのとき
                case true:
                    
                    switch tgt {
                    case true:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                    case false:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                    }
                    
                // 今、相手のターンのとき
                case false:
                    
                    switch tgt {
                        
                    case true:
                        if lang == true {
                            target = "てきの \(judge.battleField.foeBattlePokemon.name)の\n"
                        } else {
                            target = "The opposite \(judge.battleField.foeBattlePokemon.name)'s\n"
                        }
                    case false:
                        if lang == true {
                            target = "\(judge.battleField.myBattlePokemon.name)の\n"
                        } else {
                            target = "\(judge.battleField.myBattlePokemon.name)'s\n"
                        }
                    }
                }
            }
            
            
            if speedLv == oldValue + 2 || (speedLv == 6 && oldValue == 5) {
                
//                print("すばやさが ぐーんと あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)すばやさが ぐーんと あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)SPEED sharply rose!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if speedLv == oldValue + 1 {
                
//                print("すばやさが あがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)すばやさが あがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)SPEED rose!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
            else if speedLv == oldValue - 1 {
                
//                print("すばやさが さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)すばやさが さがった!")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)SPEED fell!")
                }
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
            }
            
            else if speedLv == oldValue - 2 || (speedLv == -6 && oldValue == -5) {
                
//                print("すばやさが がくっと さがった！")
                
                if lang == true {
                    myBVC.enqueue(reveivedStr: "\(target)すばやさが がくっと さがった！")
                } else {
                    myBVC.enqueue(reveivedStr: "\(target)SPEED sharply fell!")
                }
                
                myBVC.outputBattleMessageLikeTypeWriter()
                judge.storeValueToTmpVar()
                
            }
            
        }
    }
    
    
    // MARK: - 各ステータスのバフ/デバフLvから自動算出された、実際のステータス倍率
    var mag_atk: Double {
        
        get {
            if atkLv >= 0 {
                return buffAry[atkLv]
            } else {
                return debuffAry[abs(atkLv)]
            }
        }
        
        set(nv) {
            atkLv = Int(nv)
        }
    }
    
    
    var mag_def: Double {
        
        get {
            if defLv >= 0 {
                return buffAry[defLv]
            } else {
                return debuffAry[abs(defLv)]
            }
        }
        
        set(nv) {
            defLv = Int(nv)
        }
    }
    
    
    var mag_Satk: Double {
        
        get {
            if s_atkLv >= 0 {
                return buffAry[s_atkLv]
            } else {
                return debuffAry[abs(s_atkLv)]
            }
        }
        
        set(nv) {
            s_atkLv = Int(nv)
        }
    }
    
    
    var mag_Sdef: Double {
        
        get {
            if s_defLv >= 0 {
                return buffAry[s_defLv]
            } else {
                return debuffAry[abs(s_defLv)]
            }
        }
        
        set(nv) {
            s_defLv = Int(nv)
        }
    }
    
    
    var mag_speed: Double {
        
        get {
            if speedLv >= 0 {
                return buffAry[speedLv]
            } else {
                return debuffAry[abs(speedLv)]
            }
        }
        
        set(nv) {
            speedLv = Int(nv)
        }
    }
    
    
    var statsLVArray: [Int] {
        
        get {
            return [
                atkLv, defLv, s_atkLv, s_defLv, speedLv
            ]
        }
        
        set {
            
            // ポケモンチェンジ時はこちらが実行され、強制的にバフレベルがリセットされる
            if newValue == [99,99,99,99,99] {
            
                atkLv = 0
                defLv = 0
                s_atkLv = 0
                s_defLv = 0
                speedLv = 0
                
//                print("こっちが来てる！ちゃんと分岐できて、バフレベルをリセットできてます！")
                
                
            } else { // 通常の加算減算処理
            
             atkLv += newValue[0]
             defLv += newValue[1]
             s_atkLv += newValue[2]
             s_defLv += newValue[3]
             speedLv += newValue[4]
                
            }
        
        }
    }
    
    var mag_StatsArray: [Double] {
    
        return [
            mag_atk, mag_def, mag_Satk, mag_Sdef, mag_speed
        ]
        
    }
    
    //    init(atkLv: Int, defLv: Int, s_atkLv: Int, s_defLv: Int, speedLv: Int) {
    //
    //        self.atkLv = atkLv
    //        self.defLv = defLv
    //        self.s_atkLv = s_atkLv
    //        self.s_defLv = s_defLv
    //        self.speedLv = speedLv
    //    }
    
    //    init() {
    //        statsAry = [self.atkLv, self.defLv, self.s_atkLv, self.s_defLv, self.speedLv]
    //        mag_statsAry = [self.atkLv, self.defLv, self.s_atkLv, self.mag_Sdef, self.speedLv]
    //    }
    
    
    
}  // BuffStruct の終了

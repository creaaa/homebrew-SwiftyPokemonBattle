
import Foundation


// 全体の天候
enum Weather {
    case clearSky // なにもない
    case harsh // はれ
    case rain // あめ
    case sandstorm // すなあらし
    case hail // あられ
    case extremelyHarsh // ひざしが とてもつよい
    case heavyRain // つよい あめ
    case mysteriousAir // らんきりゅう
}

// 全体の「場」の状態
enum SpecialOverallField {
    case null
    case mistField
    case elekiField
    case glassField
    case psychoField
}

// 全体の「その他の場」の状態
enum OtherOverallField {
    case null
    case gravity
    case trickRoom
}

// 片方の場の状態
enum MateField {
    case null
    case reflector
    case nebanebanet
}



struct BattleField {
    
    // 現在バトル中のポケモン
    var myBattlePokemon: Pokemon
    var foeBattlePokemon: Pokemon
    
    var battleFieldPokemonArray: [Pokemon]
    
    
    // パーティ
    var myPokemon1: Pokemon
    var myPokemon2: Pokemon
    var myPokemon3: Pokemon
    var myParty: [Pokemon]
    
    var foePokemon1: Pokemon
    var foePokemon2: Pokemon
    var foePokemon3: Pokemon
    var foeParty: [Pokemon]
    
    
    //////////////////
    ///   場の状態  ///
    //////////////////
    
//    // 全体の天候
//    var weather: Weather = .clearSky
//    // 全体の「場」の状態
//    var specialOverallField: SpecialOverallField = .null
//    // 全体の「その他の場」の状態
//    var otherOverallField: [OtherOverallField] = [.null]
//    
//    // 味方の場の状態
//    var myPokemonField: [MateField] = [.null]
//    // 相手の場の状態
//    var foePokemonField: [MateField] = [.null]
    
    
//    init(myBattlePokemon: Pokemon, foeBattlePokemon: Pokemon) {
//        self.myBattlePokemon = myBattlePokemon
//        self.foeBattlePokemon = foeBattlePokemon
//        
//        battleFieldPokemonArray = [myBattlePokemon, foeBattlePokemon]
//    }

    
        init(myPokemon1: Pokemon, myPokemon2: Pokemon, myPokemon3: Pokemon, foePokemon1: Pokemon, foePokemon2: Pokemon, foePokemon3: Pokemon) {
            
            self.myBattlePokemon = myPokemon1
            
            self.foeBattlePokemon = foePokemon1
            
            // 「1ターンに 場に出た」
            self.myBattlePokemon.appeardTurn = 0
            self.foeBattlePokemon.appeardTurn = 0
            
            
            self.myPokemon1 = myPokemon1
            self.myPokemon2 = myPokemon2
            self.myPokemon3 = myPokemon3
            self.foePokemon1 = foePokemon1
            self.foePokemon2 = foePokemon2
            self.foePokemon3 = foePokemon3
    
            battleFieldPokemonArray = [myBattlePokemon, foeBattlePokemon]
            
            myParty = [myPokemon1, myPokemon2, myPokemon3]
            foeParty = [foePokemon1, foePokemon2, foePokemon3]
            
//            print("味方パーテ: \(myParty[0].name), \(myParty[1].name), \(myParty[2].name)")
        }

}

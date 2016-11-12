
import Foundation


public protocol Repository {
    
    var Pokemons: [Pokemon] { get }
    
    // なくてもいい、けしてもいい
    var Moves: [Move] { get }
    
    //    func addPerson(_ person:Person);
    //    func removePerson(_ name:String);
    //    func updatePerson(_ name:String, newCity:String);
}

public class MemoryRepository: Repository {
    
    
    fileprivate var pokemonArray: [Pokemon]
    
    
    fileprivate var moveArray: [Move]
    
    
    
    
    init() {
        
        self.moveArray = [
            
            // ピカチュウ
             Move(name: "Thunderbolt", type: .electric, desc: "sometimes give palalyze", power: 90, accuracy: 100, pp: 15, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .givePalalyze], addEffectPer: 10, buffLevel: [0,0,0,0,0], addEffectTo: true),
             
             Move(name: "Volt Tackle", type: .electric, desc: "DMG. also damage to myself", power: 120, accuracy: 100, pp: 15, priority: 0, isDirect: true, category: .physical, process: [.giveDamage, .givePalalyze, .recoil], addEffectPer: 10, buffLevel: [0,0,0,0,0], addEffectTo: true),
    
             Move(name: "Thunder Wave", type: .electric, desc: "give palalyze", power: 0, accuracy: 100, pp: 20, priority: 0, isDirect: false, category: .status, process: [.givePalalyze], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: false),
             
             Move(name: "Feint", type: .normal, desc: "can quick attack", power: 30, accuracy: 100, pp: 10, priority: 2, isDirect: true, category: .physical, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
             
            
             // フシギバナ

            Move(name: "Toxic", type: .poison, desc: "give toxic", power: 0, accuracy: 90, pp: 10, priority: 0, isDirect: false, category: .status, process: [.givePoison], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: false),
            
            Move(name: "Leaf Storm", type: .grass, desc: "DMG. sharply down my S_ATK", power: 130, accuracy: 90, pp: 5, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .getBuffDebuff], addEffectPer: 100, buffLevel: [0,0,-2,0,0], addEffectTo: true),
            
            Move(name: "Sludge Bomb", type: .poison, desc: "gives damage. often give poison", power: 90, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .givePoison], addEffectPer: 30, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Sleep Powder", type: .grass, desc: "give sleep", power: 0, accuracy: 75, pp: 15, priority: 0, isDirect: false, category: .status, process: [.giveSleep], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: false),
            
//            Move(name: "はっぱカッター", type: .grass, desc: "give damage. defenitely buff.", power: 55, accuracy: 75, pp: 15, priority: 0, isDirect: false, category: .special, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            
            // リザードン
            
            Move(name: "Flamethrower", type: .fire, desc: "gives damage", power: 90, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Hone Claws", type: .dark, desc: "rises ATK", power: 0, accuracy: 100, pp: 15, priority: 0, isDirect: false, category: .status, process: [.getBuffDebuff], addEffectPer: 100, buffLevel: [1,0,0,0,0], addEffectTo: true),
            
            Move(name: "Will-O-Wisp", type: .fire, desc: "give burn", power: 0, accuracy: 85, pp: 15, priority: 0, isDirect: false, category: .status, process: [.giveBurn], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: false),
            
            Move(name: "Flare Blitz", type: .fire, desc: "gives damage. also damages to me", power: 120, accuracy: 100, pp: 15, priority: 0, isDirect: true, category: .physical, process: [.giveDamage, .giveBurn, .recoil], addEffectPer: 10, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            
            // カメックス
            
            Move(name: "Surf", type: .water, desc: "gives damage", power: 90, accuracy: 100, pp: 15, priority: 0, isDirect: false, category: .special, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Aqua Jet", type: .water, desc: "can quick attack", power: 40, accuracy: 100, pp: 20, priority: 1, isDirect: true, category: .physical, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Iron Defense", type: .steel, desc: "sharply rise DEF", power: 0, accuracy: 100, pp: 15, priority: 0, isDirect: false, category: .status, process: [.getBuffDebuff], addEffectPer: 100, buffLevel: [0,2,0,0,0], addEffectTo: true),
            
            Move(name: "Ice Beam", type: .ice, desc: "gives damage. sometimes ice", power: 90, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .giveIce], addEffectPer: 10, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            
            // ガブリアス
            
            // <つめとぎ かぶってる　ダミー　消せ>
            Move(name: "Hone Claws", type: .dark, desc: "rise ATK", power: 0, accuracy: 100, pp: 15, priority: 0, isDirect: true, category: .status, process: [.getBuffDebuff], addEffectPer: 100, buffLevel: [1,0,0,0,0], addEffectTo: true),
            
            Move(name: "Draco Meteor", type: .dragon, desc: "damage. sharply down my S_ATK", power: 130, accuracy: 90, pp: 5, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .getBuffDebuff], addEffectPer: 100, buffLevel: [0,0,-2,0,0], addEffectTo: true),
            
            Move(name: "Dragon Claw", type: .dragon, desc: "gives damage", power: 80, accuracy: 100, pp: 15, priority: 0, isDirect: true, category: .physical, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Earthquack", type: .ground, desc: "gives damage", power: 100, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .physical, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            // フーディン [5]
            Move(name: "Calm Mind", type: .psychic, desc: "rise my S_ATK and S_DEF", power: 0, accuracy: 100, pp: 20, priority: 0, isDirect: true, category: .status, process: [.getBuffDebuff], addEffectPer: 100, buffLevel: [0,0,1,1,0], addEffectTo: true),
            
            Move(name: "Dazzling Gleam", type: .fairy, desc: "gives damage", power: 80, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Shadow Ball", type: .ghost, desc: "DMG. sometimes down foe's S_DEF", power: 80, accuracy: 100, pp: 15, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .getBuffDebuff], addEffectPer: 10, buffLevel: [0,0,0,-1,0], addEffectTo: false),
            
            Move(name: "Psychic", type: .psychic, desc: "DMG. sometimes down foe's S_DEF", power: 90, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .getBuffDebuff], addEffectPer: 10, buffLevel: [0,0,0,-1,0], addEffectTo: false),
            
            
            // コジョンド [6]
            Move(name: "High Jump Kick", type: .fighting, desc: "DMG. If you miss, injures myself", power: 130, accuracy: 100, pp: 10, priority: 0, isDirect: true, category: .physical, process: [.giveDamage, .recoil], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Swords Dance", type: .normal, desc: "rise sharply my ATTACK", power: 0, accuracy: 100, pp: 20, priority: 0, isDirect: false, category: .status, process: [.getBuffDebuff], addEffectPer: 100, buffLevel: [2,0,0,0,0], addEffectTo: true),
            
            Move(name: "Fake Out", type: .normal, desc: "give flinch.Successes only turn1", power: 40, accuracy: 100, pp: 10, priority: 3, isDirect: true, category: .physical, process: [.giveDamage, .makeFlinch], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Rock Tomb", type: .rock, desc: "DMG. definitely down foe's SPEED", power: 60, accuracy: 95, pp: 15, priority: 0, isDirect: false, category: .physical, process: [.giveDamage, .getBuffDebuff], addEffectPer: 100, buffLevel: [0,0,0,0,-1], addEffectTo: false),
            
            
            // ニンフィア
            Move(name: "Yawn", type: .normal, desc: "cause drawsiness", power: 0, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .status, process: [.makeYawn], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: false),
            
            Move(name: "Moonblast", type: .fairy, desc: "damage. often down foe's S_ATK", power: 95, accuracy: 100, pp: 15, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .getBuffDebuff], addEffectPer: 30, buffLevel: [0,0,-1,0,0], addEffectTo: false),
            
            Move(name: "Hyper Voice", type: .normal, desc: "gives damage", power: 90, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            
            Move(name: "Quick Attack", type: .normal, desc: "can quick attack", power: 40, accuracy: 100, pp: 30, priority: 1, isDirect: true, category: .physical, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            
            // ルカリオ
            Move(name: "Aura Sphere", type: .fighting, desc: "absolutely hits", power: 80, accuracy: 100, pp: 20, priority: 0, isDirect: false, category: .special, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Close Combat", type: .fighting, desc: "DMG. Down my DEF and S_DEF", power: 120, accuracy: 100, pp: 5, priority: 0, isDirect: true, category: .physical, process: [.giveDamage, .getBuffDebuff], addEffectPer: 100, buffLevel: [0,-1,0,-1,0], addEffectTo: true),
            
            Move(name: "Extreme Speed", type: .normal, desc: "gives damage. can quick attack", power: 80, accuracy: 100, pp: 5, priority: 2, isDirect: true, category: .physical, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            // かぶってる　すぐに消せ
            Move(name: "Earthquack", type: .ground, desc: "gives damage", power: 100, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .physical, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            
            // ゲンガー
            
            // <ヘドロばくだん ダミー 上にあるからもうかぶってる。消せ。>
            Move(name: "Sludge Bomb", type: .poison, desc: "gives damage. often give poison", power: 90, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage, .givePoison], addEffectPer: 30, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Destiny Bond", type: .ghost, desc: "if the Doer faints, FOE faints", power: 0, accuracy: 100, pp: 5, priority: 0, isDirect: false, category: .status, process: [.makeDestinyBond], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            
            Move(name: "Hex", type: .ghost, desc: "double DMG If foe has BadStatus", power: 65, accuracy: 100, pp: 10, priority: 0, isDirect: false, category: .special, process: [.giveDamage], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: true),
            
            Move(name: "Hypnosis", type: .psychic, desc: "give sleep", power: 0, accuracy: 60, pp: 20, priority: 0, isDirect: false, category: .status, process: [.giveSleep], addEffectPer: 100, buffLevel: [0,0,0,0,0], addEffectTo: false),

        ]
        
        self.pokemonArray = [

            // ピカチュウ HP110
            Pokemon(name: pokeName[0], type1: .electric, type2: .null, ability: .seidenki, gender: .female, lv: 50, MAXHP: 110, HP: 110, ATTACK: 91, DEFFENSE: 60, S_ATTACK: 77, S_DEFFENSE: 70, SPEED: 156, move1: moveArray[0], move2: moveArray[1], move3: moveArray[2], move4: moveArray[3]),
            
            // フシギバナ HP156
            Pokemon(name: pokeName[1], type1: .grass, type2: .poison, ability: .overgrow, gender: .male, lv: 50, MAXHP: 156, HP: 156, ATTACK: 91, DEFFENSE: 135, S_ATTACK: 120, S_DEFFENSE: 167, SPEED: 100, move1: moveArray[4], move2: moveArray[5], move3: moveArray[6], move4: moveArray[7]),
            
            // リザードン HP153
            Pokemon(name: pokeName[2], type1: .fire, type2: .flying, ability: .blaze, gender: .female, lv: 50, MAXHP: 153, HP: 153, ATTACK: 149, DEFFENSE: 88, S_ATTACK: 145, S_DEFFENSE: 105, SPEED: 136, move1: moveArray[8], move2: moveArray[9], move3: moveArray[10], move4: moveArray[11]),
            
            // カメックス HP155
            Pokemon(name: pokeName[3], type1: .water, type2: .null, ability: .torrent, gender: .male, lv: 50, MAXHP: 155, HP: 155, ATTACK: 92, DEFFENSE: 167, S_ATTACK: 105, S_DEFFENSE: 157, SPEED: 98, move1: moveArray[12], move2: moveArray[13], move3: moveArray[14], move4: moveArray[15]),
            
            // ガブリアス HP183
            Pokemon(name: pokeName[4], type1: .ground, type2: .dragon, ability: .roughskin, gender: .female, lv: 50, MAXHP: 183, HP: 183, ATTACK: 200, DEFFENSE: 115, S_ATTACK: 90, S_DEFFENSE: 105, SPEED: 154, move1: moveArray[16], move2: moveArray[17], move3: moveArray[18], move4: moveArray[19]),
            
            
            
            // フーディン HP130
            Pokemon(name: pokeName[5], type1: .psychic, type2: .null, ability: .innerfocus, gender: .male, lv: 50, MAXHP: 130, HP: 130, ATTACK: 63, DEFFENSE: 65, S_ATTACK: 205, S_DEFFENSE: 116, SPEED: 172, move1: moveArray[20], move2: moveArray[21], move3: moveArray[22], move4: moveArray[23]),
            
            // コジョンド HP140
            Pokemon(name: pokeName[6], type1: .fighting, type2: .null, ability: .reckless, gender: .male, lv: 50, MAXHP: 140, HP: 140, ATTACK: 177, DEFFENSE: 81, S_ATTACK: 103, S_DEFFENSE: 80, SPEED: 172, move1: moveArray[24], move2: moveArray[25], move3: moveArray[26], move4: moveArray[27]),
            
            // ニンフィア HP171
            Pokemon(name: pokeName[7], type1: .fairy, type2: .null, ability: .pixilate, gender: .female, lv: 50, MAXHP: 171, HP: 171, ATTACK: 76, DEFFENSE: 85, S_ATTACK: 178, S_DEFFENSE: 182, SPEED: 80, move1: moveArray[28], move2: moveArray[29], move3: moveArray[30], move4: moveArray[31]),
            
            // ルカリオ HP145
            Pokemon(name: pokeName[8], type1: .fighting, type2: .steel, ability: .steadfast, gender: .male, lv: 50, MAXHP: 145, HP: 145, ATTACK: 178, DEFFENSE: 90, S_ATTACK: 151, S_DEFFENSE: 106, SPEED: 99, move1: moveArray[32], move2: moveArray[33], move3: moveArray[34], move4: moveArray[35]),
            
            // ゲンガー HP 135
            Pokemon(name: pokeName[9], type1: .ghost, type2: .poison, ability: .levitate, gender: .female, lv: 50, MAXHP: 135, HP: 135, ATTACK: 76, DEFFENSE: 80, S_ATTACK: 200, S_DEFFENSE: 96, SPEED: 162, move1: moveArray[36], move2: moveArray[37], move3: moveArray[38], move4: moveArray[39]),
            
            
            Pokemon(name: "Mew", type1: .psychic, type2: .null, ability: .overgrow, gender: .unknown, lv: 50, MAXHP: 175, HP: 175, ATTACK: 108, DEFFENSE: 120, S_ATTACK: 167, S_DEFFENSE: 121, SPEED: 152, move1: moveArray[20], move2: moveArray[23], move3: moveArray[32], move4: moveArray[37])
        ]
        
    }
    
    public var Pokemons: [Pokemon] {
        return self.pokemonArray
    }
    
    public var Moves: [Move] {
        return self.moveArray
    }
    
//    func addPerson(_ pokemon: Pokemon) {
//        self.pokemonArray.append(pokemon)
//    }
//    
//    func removePerson(_ name: String) {
//        let nameLower = name.lowercased()
//        self.pokemonArray = pokemonArray.filter({ $0.name.lowercased() != nameLower })
//    }
//    
//    func updatePerson(_ name: String, newName: String) {
//        let nameLower = name.lowercased();
//        let test:(Pokemon) -> Bool = { p in return
//            p.name.lowercased() == nameLower
//        }
//        if let pokemon = pokemonArray.first(test) {
//            pokemon.name = newName
//        }
//    }
}

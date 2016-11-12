import Foundation

enum Command: String {
    
    case MOVE1 = "1: move1"
    case MOVE2 = "2: move2"
    case MOVE3 = "3: move3"
    case MOVE4 = "4: move4"
    
    case CHANGE_POKEMON = "p: Pokemon Change"
    
    
    case CONDITION = "c: Condition"

    
    case SURRENDER = "s: Surrender"
    
    case EXCEPTION
    
    
    static let ALL = [
        Command.MOVE1, Command.MOVE2, Command.MOVE3, Command.MOVE4, Command.CHANGE_POKEMON, Command.CONDITION, Command.SURRENDER, Command.EXCEPTION
    ]
    
    static func getFromInput(_ input:String) -> Command? {
        switch (input.lowercased()) {
        case "1":
            return Command.MOVE1
        case "2":
            return Command.MOVE2
        case "3":
            return Command.MOVE3
        case "4":
            return Command.MOVE4
        case "p":
            return Command.CHANGE_POKEMON
        case "c":
//            turn -= 1
            return Command.CONDITION
//        case "s":
            
            // ここでこっそりturnを-1している。せこい。
//            turn -= 1
//            return Command.SURRENDER
        default:
            // ここでこっそりturnを-1している。せこい。
            turn -= 1
            return Command.EXCEPTION
        }
    }
}


enum PokemonChangeSceneCommand: String {
    
    case choosePokemon1 = "1: Pokemon1"
    case choosePokemon2 = "2: Pokemon2"
    case choosePokemon3 = "3: Pokemon3"
    case quit = "Quit"
    
    static let ALL = [
        PokemonChangeSceneCommand.choosePokemon1, PokemonChangeSceneCommand.choosePokemon2, PokemonChangeSceneCommand.choosePokemon3, PokemonChangeSceneCommand.quit
    ]
    
    static func getFromInput(_ input:String) -> PokemonChangeSceneCommand? {
        switch input {
        case "1":
            return PokemonChangeSceneCommand.choosePokemon1
        case "2":
            return PokemonChangeSceneCommand.choosePokemon2
        case "3":
            return PokemonChangeSceneCommand.choosePokemon3
        case "q":
            return PokemonChangeSceneCommand.quit
        default:
            return PokemonChangeSceneCommand.quit
        }
    }
}



//enum FieldConditionCommand: String {
//    
//    case condition = "c: Condition"
//    
//    static let ALL = [
//        FieldConditionCommand.condition
//    ]
//    
//    static func getFromInput(_ input:String) -> Command? {
//        switch (input.lowercased()) {
//        case "c":
//            return FieldConditionCommand.condition
//    }
//}






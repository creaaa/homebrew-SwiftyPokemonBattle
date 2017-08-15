
import Foundation

class ControllerBase {
    
    fileprivate let repository: Repository
    fileprivate let nextController: ControllerBase?
    
    init(repo:Repository, nextController: ControllerBase?) {
        self.repository = repo
        self.nextController = nextController
    }
    
    func handleCommand(_ command:Command, data:[String]) -> View? {
        return nextController?.handleCommand(command, data:data)
    }
}


class PokemonController: ControllerBase {
    
    override func handleCommand(_ command:Command, data:[String]) -> View? {
        
        switch command {
            case .MOVE1:
                return listAll()
            case .MOVE2:
                return listAll()
            case .MOVE3:
                return listAll()
            case .MOVE4:
                return listAll()
            case .CHANGE_POKEMON:
                return listAll()
            case .CONDITION:
                return condition()
            case .SURRENDER:
                return surrender()
            case .EXCEPTION:
                return exception()
        }
    }
    

    fileprivate func listAll() -> View {
        return PokemonListView(data: repository.Pokemons)
    }

    
    fileprivate func condition() -> View {
        return AnalyzeView()
    }
    
    fileprivate func surrender() -> View {
        return SurrenderView()
    }
    
    fileprivate func exception() -> View {
        return ExceptionView()
    }
    
}


class FieldConditionController: ControllerBase {
    
    
    override func handleCommand(_ command: Command, data: [String]) -> View? {
        
        switch command {
            default:
                return super.handleCommand(command, data: data)
        }
    }
    
    
    fileprivate func condition() -> View {
        return FieldConditionView()
    }
}




import Foundation

@objc
protocol View {
    func execute()
    @objc optional func execute(cmd: Int)
}

class ArgsExecuteView: View {
    
    func execute() {
        FunctionCalledFromMain.launchArgsExecuteView()
    }
}

class PokemonEditView: View {
    
    func execute() {
//        print("こっちは行われないはず")
    }
    
    func execute(cmd: Int) {
        FunctionCalledFromMain.launchPokemonEditView(cmd: cmd)
    }
}

class PokemonSelectView: View {
    
    func execute() {
        FunctionCalledFromMain.launchPokemonSelectView()
    }
}


class PokemonListView : View {
    
    fileprivate let pokemons: [Pokemon]
    
    init(data:[Pokemon]) {
        self.pokemons = data
    }
    
    
    func execute() {
    }
}


class PokemonChangeView: View {
    
    func execute() {
        
        FunctionCalledFromMain.launchPokemonChangeView()
    }
}



class AnalyzeView: View {
    
    func execute() {
        
        // アナライズ画面(バフ・デバフとか)を描画する関数
        print(FunctionCalledFromMain.launchAnalyzeView(BF: judge.battleField))
        
    }
}


class FieldConditionView: View {
    
    func execute() {
        
        // コンディション画面を描画する関数
        print(FunctionCalledFromMain.launchConditionView(BF: judge.battleField))

        
    }
}


class SurrenderView: View {
    func execute() {
//        print("あなたは 勝ちました")
    }
}


class ExceptionView: View {
    func execute() {
//        print("例外です")
    }
}

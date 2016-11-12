
import Foundation

public func == (lhs: Move, rhs: Move) -> Bool {
    return lhs.name == rhs.name
}


public class Move: NSObject, NSCoding {
    
    let name: String
    let type: Type
    let desc: String
    
    let power: Int
    let accuracy: Int
    let pp: Int
    
    let priority: Int
    let isDirect: Bool
    
    
    let category: MoveCategory
    var process: [MoveProcess] = []
    
    var processCount: Int
    
    // 追加効果の発生確率
    let addEffectPer: Int
    
    // 追加効果の発動先が「自分(true)」か「相手(false)」か
    var addEffectTo: Bool
    
    
    // バフ・デバフ効果があるわざの場合、どの能力値を何段階 ± させるか。
    // [こうげき・ぼうぎょ・とくこう・とくぼう・すばやさ]の順。
    var buffLevel: [Int] = []
    
    
    // シリアライズ処理で使う

    var moveProcessKeyAry: [String] = []
    
    let buffKeyAry = ["buff_attack","buff_defense","buff_s_atk","buff_s_def","buff_speed"]
    
    
    init(name: String, type: Type, desc: String, power: Int, accuracy: Int, pp: Int, priority: Int, isDirect: Bool, category: MoveCategory, process: [MoveProcess], addEffectPer: Int, buffLevel: [Int], addEffectTo: Bool) {
        
        self.name = name
        self.type = type
        self.desc = desc
        self.power = power
        self.accuracy = accuracy
        self.pp = pp
        
        self.priority = priority
        self.isDirect = isDirect
        
        
        self.category = category
        self.process = process
            self.processCount = process.count
        self.addEffectPer = addEffectPer
        
//        self.addEffectTo = true
        
        self.buffLevel = buffLevel
        self.addEffectTo = addEffectTo
        
        
        for eachProcess in self.process {
            
            switch eachProcess {
            case .null:
                self.moveProcessKeyAry.append("process_null")
            case .giveDamage:
                self.moveProcessKeyAry.append("process_giveDamage")
            case .healHP:
                self.moveProcessKeyAry.append("process_healHP")
            case .givePalalyze:
                self.moveProcessKeyAry.append("process_givePalalyze")
            case .giveBurn:
                self.moveProcessKeyAry.append("process_giveBurn")
            case .giveIce:
                self.moveProcessKeyAry.append("process_giveIce")
            case .giveSleep:
                self.moveProcessKeyAry.append("process_giveSleep")
            case .givePoison:
                self.moveProcessKeyAry.append("process_givePoison")
            case .recoil:
                self.moveProcessKeyAry.append("process_recoil")
            case .getBuffDebuff:
                self.moveProcessKeyAry.append("process_getBuffDebuff")
            case .makeDestinyBond:
                self.moveProcessKeyAry.append("process_makeDestinyBond")
            case .makeYawn:
                self.moveProcessKeyAry.append("process_makeYawn")
            case .makeFlinch:
                self.moveProcessKeyAry.append("process_makeFlinch")
            }
            
        }
        
//        print("この時点でプロセスが設定されてないとヤバイ。\(name) \(moveProcessKeyAry) どや！")
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        
        self.name = aDecoder.decodeObject(forKey: "moveName") as! String
        
        let typeRaw = aDecoder.decodeInteger(forKey: "moveType")
        self.type = Type(rawValue: typeRaw)!
        
        self.desc = aDecoder.decodeObject(forKey: "moveDesc") as! String
        
        self.power = aDecoder.decodeInteger(forKey: "movePower")
        self.accuracy = aDecoder.decodeInteger(forKey: "moveAccuracy")
        self.pp = aDecoder.decodeInteger(forKey: "movePP")
        
        self.priority = aDecoder.decodeInteger(forKey: "movePriority")
        self.isDirect = aDecoder.decodeBool(forKey: "moveIsDirect")
        self.addEffectTo = aDecoder.decodeBool(forKey: "moveAddEffectTo")
        
        
        
        // 解凍処理でエラーが起きるとしたら、ここだ。category列挙体を Intからstringに変更したからね。
        
        let moveCategoryRaw = aDecoder.decodeObject(forKey: "moveCategory")
        self.category = MoveCategory(rawValue: moveCategoryRaw as! String)!
        
        
//        var count = 0
        
        
        self.processCount = aDecoder.decodeInteger(forKey: "moveProcessCount")

        
        var decodeProcessCount = 0
        
        //for _ in moveProcessKeyAry {
        
        for _ in 1...processCount {
        
            //print("\(self.name)の解凍パス: \(name)\(moveProcessKeyAry[decodeProcessCount])")
            
            let moveProcessRaw = aDecoder.decodeInteger(forKey: "moveProcess\(decodeProcessCount)")
            
            //print("\(self.name): これが生。\(moveProcessRaw)")
            
            self.process.append(MoveProcess(rawValue: moveProcessRaw)!)
                        
            decodeProcessCount += 1
        }
        
//        self.process = [MoveProcess(rawValue: aDecoder.decodeInteger(forKey: "moveProcess1"))!]
        
//        let moveProcessKeyAry = ["moveProcess1","moveProcess2","moveProcess3","moveProcess4","moveProcess5"]
//        var count = 0
//        for eachMoveProcess in process {
//            aCoder.encode(eachMoveProcess.rawValue, forKey: moveProcessKeyAry[count])
//            count += 1
//        }
        
        self.addEffectPer = aDecoder.decodeInteger(forKey: "moveAddEffectPer")
        self.addEffectTo = aDecoder.decodeBool(forKey: "moveAddEffectTo")
        
        var moveBuffCount = 0
        
        for _ in buffKeyAry {
            self.buffLevel.append(aDecoder.decodeInteger(forKey: buffKeyAry[moveBuffCount]))
            moveBuffCount += 1
        }
    }
    
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "moveName")
        aCoder.encode(type.rawValue, forKey: "moveType")
        aCoder.encode(desc, forKey: "moveDesc")
        
        aCoder.encode(power, forKey: "movePower")
        aCoder.encode(accuracy, forKey: "moveAccuracy")
        aCoder.encode(pp, forKey: "movePP")
        
        aCoder.encode(priority, forKey: "movePriority")
        aCoder.encode(isDirect, forKey: "moveIsDirect")
        
        aCoder.encode(category.rawValue, forKey: "moveCategory")
        
//        let moveProcessKeyAry = ["moveProcess1","moveProcess2","moveProcess3","moveProcess4","moveProcess5"]
        
        var processCount = 0
        for eachMoveProcess in process {
            
//            print("俺が \(name)だ")
//            
//            print("入れることは　入れる")
//            print("\(eachMoveProcess)だよ")
//             print("カウントは \(processCount)だよ")
//            
//            print("保存する値は \(eachMoveProcess.rawValue)やで")
            
            aCoder.encode(eachMoveProcess.rawValue, forKey: "moveProcess\(processCount)")
            
            processCount += 1
        }
        
        aCoder.encode(processCount, forKey: "moveProcessCount")
        
        aCoder.encode(addEffectPer, forKey: "moveAddEffectPer")
        aCoder.encode(addEffectTo, forKey: "moveAddEffectTo")
        
        var moveBuffCount = 0
        for eachStatsBuffLevel in buffLevel {
            aCoder.encode(eachStatsBuffLevel, forKey: buffKeyAry[moveBuffCount])
            moveBuffCount += 1
        }
        //        moveArray = [move1, move2, move3, move4]
    }
    
}

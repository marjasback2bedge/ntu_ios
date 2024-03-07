//import Cocoa

//var greeting = "Hello, playground"
//四則運算
/// ----- 練習 1：宣告與四則運算 -----
// 宣告價格、折扣、消費稅變數，運算出價格。
// 印出：商品費用 Ｏ 元，打 Ｏ 折，加上消費稅 Ｏ%，您需要支付 Ｏ 元。
// ＊消費稅是根據折扣完的金額計算。
// ＊請在Ｏ的部分放入變數，不要直接寫數字。
// ＊打 9 折印出「打 9.0 折」或是「打 90 折」都可以，等一下會調整。
// ＊價格為 100、折扣是 0.1、消費稅是 8% 的情況，費用應運算出 97.2 元。
import Foundation //for formating
let price = 100
let discount = 0.1
let taxRate = 8
let value = Double(price) * (1 - discount) * (1 + Double(taxRate) / 100)
print("商品費用 \(price) 元，打 \((1 - discount).formatted(.number.scale(10))) 折，加上消費稅 \(taxRate) %，您需要支付\(value) 元。")
/// ----- 練習 2：分支控制流 -----
// 計算睡眠效率（efficiency），並根據睡眠效率和時間顯示評語。
// 印出：睡眠效率：Ｏ%，評語。
// ＊睡眠效率公式：睡眠時間 ÷ 躺在床上的時間
// ＊充足睡眠：睡著的時間至少 7 小時。
// ＊睡眠品質好：睡眠效率至少 85%。
// ＊評語：
//     睡得好：充足睡眠、睡眠品質好。
//     睡眠品質不佳：充足睡眠、睡眠品質不好。
//     睡太少：睡眠不足、睡眠品質好。
//     不行哦：睡眠不足、睡眠品質不好。
// ＊結果應顯示正確的睡眠效率是：84.96994%，睡眠品質不佳。


let asleepMinutes = 424
let onBedMinutes  = 499
let effect: Double = Double(asleepMinutes) / Double (onBedMinutes)
var comment: String = ""
if( effect < 0.85 && asleepMinutes < 420 ) { comment = "不行哦：睡眠不足、睡眠品質不好。" }
else if( asleepMinutes >= 420 && effect < 0.85 ) { comment = "睡眠品質不佳：充足睡眠、睡眠品質不好。"}
else if( asleepMinutes < 420 && effect >= 0.85 ) { comment = "睡太少：睡眠不足、睡眠品質好。"}
else { comment = "睡得好：充足睡眠、睡眠品質好。"}
print("睡眠效率：\(effect.formatted(.percent)) %，\(comment)")


/// ----- 練習 3：Collection & Loop -----
//way to init array
var num = [1, 2, 3] //array<int>
//let emptyIntArray = [Int]()
let array: [Any] = [1, "2"] // old way, not good
num.append(7)
num.insert(0, at: 1)
//[1, 0, 2, 3, 7]
num.remove(at: 1)
//[1, 2, 3, 7]
//wat to init dict
let phoneBook = [
    "mom": "091234567",
    "dad": "098765432",
] //[string, string]
phoneBook["bro", default: "none"]
//拆解tuple
for( name, number ) in phoneBook{
    print("\(name)的號碼：\(number)")
}
// 印出：睡眠效率最高紀錄者是 Ｏ，在第 Ｏ 天，Ｏ%。
// ＊睡眠效率公式：睡眠時間 ÷ 躺在床上的時間
// ＊不會有相同分數的情況。
// ＊最高紀錄者應是 David，第六天，97%。

/// Key 是名字，Value 是過去七天的睡眠狀況。
let sleepEfficiencyRecords: [String: [Double]] = [
    "Ann": [0.93, 0.9, 0.89, 0.85, 0.88, 0.91, 0.92],
    "Zoe": [0.88, 0.87, 0.89, 0.9, 0.91, 0.92, 0.96],
    "David": [0.81, 0.88, 0.79, 0.81, 0.77, 0.97, 0.91],
    "Ray": [0.92, 0.93, 0.91, 0.76, 0.96, 0.91, 0.92],
]
var highestName: String = ""
var highestTime: Double = 0.0
var recordTime: Int = 0
var bestRecord: (name: String, day: Int, score: Double) = ("", 0, -1) //tuple
for( name, records ) in sleepEfficiencyRecords{
    for index in records.enumerated(){
        if( records[index.offset] > highestTime ){
            highestName = name
            highestTime = records[index.offset]
            recordTime = index.offset + 1
        }
    }
}
print("睡眠效率最高紀錄者是\(highestName)，在第\(recordTime)天，\(highestTime.formatted(.percent))。")
/// ----- 練習 4：Tuple -----
// 接續上一題，改用 Tuple。
// 印出：
// 睡眠效率最高紀錄者是 Ｏ，在第 Ｏ 天，Ｏ%。
// 睡眠效率最低紀錄者是 Ｏ，在第 Ｏ 天，Ｏ%。
// 平均睡眠效率最好的人是 Ｏ。
// ＊不會有相同分數的情況。
// ＊最高紀錄者應是 David，第六天，97%。
// ＊最低紀錄者應是 Ray，第四天，76%。
// ＊平均最高睡眠效率者應該是 Zoe。
//
// ＊參考示範：
// typealias Record = (name: String, day: Int, score: Double)
// var bestRecord: Record = ("", 0 , -1)
typealias Record = (name: String, day: Int, score: Double) //有點像typedef
var bestRecord4: Record = ("", 0 , -1)
var worstRecord4: Record = ("", 0 , -1)
var bestTtlScore = 0.0
var bestTtlName = ""
var firstRound = true
for( name, records ) in sleepEfficiencyRecords{
    var ttlRecord = 0.0
    for (day, record) in records.enumerated(){
        ttlRecord += record
        if firstRound {
            worstRecord4.name = name
            worstRecord4.day = day + 1
            worstRecord4.score = record
        }
        if( record > bestRecord4.score ){
            bestRecord4.name = name
            bestRecord4.day = day + 1
            bestRecord4.score = record
        }
        if( record < worstRecord4.score ){
            worstRecord4.name = name
            worstRecord4.day = day + 1
            worstRecord4.score = record
        }
        firstRound = false
    }
    if ttlRecord > bestTtlScore{
        bestTtlScore = ttlRecord
        bestTtlName = name
    }
}
print("睡眠效率最高紀錄者是\(bestRecord4.name)，在第\(bestRecord4.day)天，\(bestRecord4.score.formatted(.percent))。")
print("睡眠效率最低紀錄者是\(worstRecord4.name)，在第\(worstRecord4.day)天，\(worstRecord4.score.formatted(.percent))。")
print("平均睡眠效率最好的人是\(bestTtlName)。")

struct sleepRecord {
    let user: String
    let score: Double
    let day: Int
    func isBetterThan(_record: sleepRecord) -> Bool{
        score > _record.score
    }
}



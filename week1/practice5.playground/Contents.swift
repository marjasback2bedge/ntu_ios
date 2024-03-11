import Foundation
/// ----- 練習 5：建立 struct & Debug -----
// 建立 User 和 SleepRecord 類型。修改以下程式碼，讓整份文件可以執行並印出正確答案。

struct User {
    let name: String
    let averageSleepHours: Double
    let averageSleepEfficiency: Double
    var hasEnoughSleep: Bool {
        averageSleepHours >= 7
    }
    var hasEfficientSleep: Bool {
        averageSleepEfficiency >= 0.85
    }
    //in this way, when the records updated, both of them will update as well
    // ⚠️ 請勿修改啟動參數。
    init(name: String, sleepRecords: [SleepRecord]) {
        self.name = name
        var totalSleepMin = 0.0
        var totalEfficiency = 0.0
        for record in sleepRecords {
            totalSleepMin += record.asleepMinutes
            totalEfficiency += record.efficiency
        }
        averageSleepHours = totalSleepMin / Double(sleepRecords.count) / 60.0
        averageSleepEfficiency = totalEfficiency / Double(sleepRecords.count)
       /* hasEnoughSleep = averageSleepHours >= 7 ? true : false
        hasEfficientSleep = averageSleepEfficiency >= 0.85 ? true : false */ //my answer
    }
}
struct SleepRecord {
    let asleepMinutes: Double
    var efficiency: Double
    // ⚠️ 請勿修改啟動參數。
    init(asleepMinutes: Double, onBedMinutes: Double) {
        self.asleepMinutes = asleepMinutes
        self.efficiency = asleepMinutes / onBedMinutes
    }
}


// ⚠️ 請勿修改以下程式碼。
let user1 = User(name: "Ian", sleepRecords: [
    SleepRecord(asleepMinutes: 440, onBedMinutes: 480),
    SleepRecord(asleepMinutes: 462, onBedMinutes: 518),
    SleepRecord(asleepMinutes: 500, onBedMinutes: 520),
    SleepRecord(asleepMinutes: 438, onBedMinutes: 485),
    SleepRecord(asleepMinutes: 260, onBedMinutes: 420)
])

let user2 = User(name: "Billy", sleepRecords: [
    SleepRecord(asleepMinutes: 480, onBedMinutes: 540),
    SleepRecord(asleepMinutes: 300, onBedMinutes: 330),
    SleepRecord(asleepMinutes: 420, onBedMinutes: 440),
    SleepRecord(asleepMinutes: 365, onBedMinutes: 420),
])

let user3 = User(name: "Ellen", sleepRecords: [
    SleepRecord(asleepMinutes: 390, onBedMinutes: 450),
    SleepRecord(asleepMinutes: 400, onBedMinutes: 480),
    SleepRecord(asleepMinutes: 330, onBedMinutes: 420),
    SleepRecord(asleepMinutes: 330, onBedMinutes: 350),
    SleepRecord(asleepMinutes: 270, onBedMinutes: 340)
])

let users = [user1, user2, user3]


for user in users {
    print("""
    \(user.name) 平均睡眠 \(user.averageSleepHours.formatted(.number.precision(.fractionLength(2)))) 小時，\
    睡眠效率 \(user.averageSleepEfficiency.formatted(.percent.precision(.fractionLength(2))))。\
    \(user.hasEnoughSleep ? "睡得夠": "睡不夠")，\
    \(user.hasEfficientSleep ? "睡得好": "睡不好")。
    """)
}

// ＊你應該要印出：
// Ian 平均睡眠 7.00 小時，睡眠效率 85.84%。睡得夠，睡得好。
// Billy 平均睡眠 6.52 小時，睡眠效率 90.54%。睡不夠，睡得好。
// Ellen 平均睡眠 5.73 小時，睡眠效率 84.45%。睡不夠，睡不好。

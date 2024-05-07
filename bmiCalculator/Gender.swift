enum Gender {
    case female
    case male
    
    var symbol: String {
        switch self {
            case .female:
                "♀"
            case .male:
                "♂"
        }
    }
    
    var description: String {
        switch self {
            case .female:
                "女生"
            case .male:
                "男生"
        }
    }
}

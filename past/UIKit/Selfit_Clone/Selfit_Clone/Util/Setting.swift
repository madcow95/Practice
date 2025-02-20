//
//  Setting.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/21.
//

import Foundation

struct Setting {
    
    static var currentLanguage: Language = .korean
    static var currentTheme: Theme = .dark
    static var calendarOption: CalendarOption = .monthly
    static var workoutComplete: WorkoutComlete = .set
    
    enum Language: String {
        case korean = "한국어"
        case english = "영어"
    }

    enum Theme: String {
        case dark = "어두운 모드"
        case light = "밝은 모드"
    }

    enum CalendarOption: String {
        case monthly = "월간"
        case weekly = "주간"
    }
    
    enum WorkoutComlete: String {
        case set = "세트 단위"
    }
    
//    func getCurrentLang() -> Language {
//        let copiedLang = self.currentLanguage
//        return copiedLang
//    }
//    
//    mutating func setCurrnetLang(lang: Language) {
//        self.currentLanguage = lang
//    }
//    
//    func getCurrentTheme() -> Theme {
//        let copiedTheme = self.currentTheme
//        return copiedTheme
//    }
//    
//    mutating func setCurrentTheme(theme: Theme) {
//        self.currentTheme = theme
//    }
//    
//    func getCurrentCalendarOption() -> CalendarOption {
//        let copiedCalendarOption = self.calendarOption
//        return copiedCalendarOption
//    }
//    
//    mutating func setCurrentCalendarOption(option: CalendarOption) {
//        self.calendarOption = option
//    }
}

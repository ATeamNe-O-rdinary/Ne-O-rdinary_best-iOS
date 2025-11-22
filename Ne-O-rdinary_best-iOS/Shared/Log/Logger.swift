//
//  LogLevel.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//


//
//  Logger.swift
//  SharedUtility
//
//  Created by Junghyun Lee on 4/30/25.
//  Copyright © 2025 com.deepfine. All rights reserved.
//

import Foundation

public enum LogLevel: String, Comparable {
  case debug = "DEBUG"
  case info = "INFO"
  case warning = "WARNING"
  case error = "ERROR"
  
  var emoji: String {
    switch self {
    case .debug:
      return "🐛"
    case .info:
      return "ℹ️"
    case .warning:
      return "⚠️"
    case .error:
      return "❌"
    }
  }
  
  var colorCode: String {
    switch self {
    case .debug:
      return "\u{001B}[0;34m" // 파란색
    case .info:
      return "\u{001B}[0;32m" // 초록색
    case .warning:
      return "\u{001B}[0;33m" // 노란색
    case .error:
      return "\u{001B}[0;31m" // 빨간색
    }
  }
  
  // Comparable 프로토콜 구현
  public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
    let order: [LogLevel] = [.debug, .info, .warning, .error]
    return order.firstIndex(of: lhs)! < order.firstIndex(of: rhs)!
  }
}

public class Logger {
  
  // 현재 활성화된 로그 레벨 설정
  public static var currentLogLevel: LogLevel = .debug
  
  // 이모지 사용 여부 설정
  public static var useEmoji: Bool = true
  
  // 로그 메시지를 출력하는 기본 메서드
  private static func log(_ level: LogLevel, message: String, file: String, function: String, line: Int) {
    if shouldLog(level) {
      let fileName = (file as NSString).lastPathComponent
      let timestamp = getCurrentTimestamp()
      let emoji = useEmoji ? level.emoji + " " : ""
      let color = level.colorCode
      let logMessage = "[\(timestamp)] [\(emoji)\(level.rawValue)] [\(fileName):\(line) \(function)] - \(message)"
      print("\(color)\(logMessage)")
    }
  }
  
  // 각 로그 레벨별 메서드
  public static func d(_ message: String,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
    log(.debug, message: message, file: file, function: function, line: line)
  }
  
  public static func i(_ message: String,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
    log(.info, message: message, file: file, function: function, line: line)
  }
  
  public static func w(_ message: String,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
    log(.warning, message: message, file: file, function: function, line: line)
  }
  
  public static func e(_ message: String,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
    log(.error, message: message, file: file, function: function, line: line)
  }
  
  // 로그 레벨 필터링
  private static func shouldLog(_ level: LogLevel) -> Bool {
    return level >= currentLogLevel
  }
  
  // 현재 시간 가져오기
  private static func getCurrentTimestamp() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return formatter.string(from: Date())
  }
}

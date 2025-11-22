//
//  TechStack.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum TechStack: String, Decodable {
    case swift = "SWIFT"
    case kotlin = "KOTLIN"
    case java = "JAVA"
    case flutter = "FLUTTER"
    case reactNative = "REACT_NATIVE"
    case nodeJS = "NODE_JS"
    case pythonDjangoFastAPI = "PYTHON_DJANGO_FASTAPI"
    case springJava = "SPRING_JAVA"
    
    var description: String {
        switch self {
        case .swift: return "Swift"
        case .kotlin: return "Kotlin"
        case .java: return "Java"
        case .flutter: return "Flutter"
        case .reactNative: return "React Native"
        case .nodeJS: return "Node.js"
        case .pythonDjangoFastAPI: return "Python(Django/FastAPI)"
        case .springJava: return "Spring(Java)"
        }
    }
}
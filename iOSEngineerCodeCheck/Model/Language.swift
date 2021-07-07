//
//  Language.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

enum Language: String {
    // 参考　https://madnight.github.io/githut/#/issues/2020/4　top 30
    case Python
    case JavaScript
    case Java
    case cpp = "C++"
    case Go
    case TypeScript
    case CSharp = "C#"
    case C
    case Ruby
    case Dart
    case Shell
    case Kotlin
    case Swift
    case Scala
    case ObjectiveC = "Objective-C"
    case Rust
    case Lua
    case EmacsLisp = "Emacs Lisp"
    case Groovy
    case Perl
    case R
    case Haskell
    case CoffeeScript
    case Elixir
    case DM
    case OCaml
    case PowerShell
    case VimScript = "Vim Script"
    case TSQL
    
    var colorHex: String? {
        switch self {
        case .Python:
            return JSONFiles.python
        case .JavaScript:
            return JSONFiles.javaScript
        case .Java:
            return JSONFiles.java
        case .cpp:
            return JSONFiles.cpp
        case .Go:
            return JSONFiles.go
        case .TypeScript:
            return JSONFiles.typeScript
        case .CSharp:
            return JSONFiles.cSharp
        case .C:
            return JSONFiles.c
        case .Ruby:
            return JSONFiles.ruby
        case .Dart:
            return JSONFiles.dart
        case .Shell:
            return JSONFiles.shell
        case .Kotlin:
            return JSONFiles.kotlin
        case .Swift:
            return JSONFiles.swift
        case .Scala:
            return JSONFiles.scala
        case .ObjectiveC:
            return JSONFiles.objectiveC
        case .Rust:
            return JSONFiles.rust
        case .Lua:
            return JSONFiles.lua
        case .EmacsLisp:
            return JSONFiles.emacsLisp
        case .Groovy:
            return JSONFiles.groovy
        case .Perl:
            return JSONFiles.perl
        case .R:
            return JSONFiles.r
        case .Haskell:
            return JSONFiles.haskell
        case .CoffeeScript:
            return JSONFiles.coffeeScript
        case .Elixir:
            return JSONFiles.elixir
        case .DM:
            return JSONFiles.dm
        case .OCaml:
            return JSONFiles.oCaml
        case .PowerShell:
            return JSONFiles.powerShell
        case .VimScript:
            return JSONFiles.vimScript
        default:
            return nil
        }
    }
    
    var color: UIColor? {
        return self.colorHex.flatMap { UIColor.init(hexString: $0) }
    }
}

//
//  main.swift
//  Gæt et nummer
//
//  Created by Emil Jensen on 08/05/2018.
//  Copyright © 2018 Emil Jensen, Nikolai Povlsen and Mikkel Norre Nielsen. All rights reserved.
//

import Foundation

var forsøg = 7

let randomNumber = arc4random_uniform(101)

var vundet: Bool = false

print("Gæt et tal mellem 0 og 100 - Begge tal inklusiv:-)")


while forsøg > 0 {
    let temp:String = readLine() ?? ""
    let int:Int = Int(temp) ?? 0

    if int == randomNumber {
        print("Najs - Godt gættet")
        vundet = true
        break
    }
    else if int > randomNumber {
        print("Det er mindre end \(int)")
    } else {
        print("Det er større end \(int)")
    }
    
    forsøg -= 1
    print("Du har \(forsøg) forsøg tilbage")
}

if vundet {
    print("Du har vundet")
} else {
    print("Du har tabt")
}


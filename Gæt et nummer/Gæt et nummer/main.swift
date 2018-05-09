import Foundation
let randomNumber = arc4random_uniform(101)
print("Gæt et tal mellem 0 og 100 - Begge tal inklusiv:-)")
for i in stride(from: 7, to: 0, by: -1) { let int:Int = Int(readLine() ?? "") ?? 0
    if int == randomNumber { print("Du har vundet")
        break } else if int > randomNumber { print("Det er mindre end \(int), du har \(i-1) forsøg tilbage") } else { print("Det er større end \(int), du har \(i-1) forsøg tilbage") }
    if (i-1 <= 0) { print("Du har tabt") } }




//let randomNumber = arc4random_uniform(101)
print("Gæt et tal mellem 0 og 100 - Begge tal inklusiv:-)")
for i in stride(from: 7, to: 0, by: -1) { let int:Int = Int(readLine() ?? "") ?? 0
    if int == randomNumber { print("Du har vundet") } else if int > randomNumber { print("Det er mindre end \(int), du har \(i-1) forsøg tilbage") } else { print("Det er større end \(int), du har \(i-1) forsøg tilbage") }
    if (i-1 <= 0) { print("Du har tabt") } else if int == randomNumber{ break} }

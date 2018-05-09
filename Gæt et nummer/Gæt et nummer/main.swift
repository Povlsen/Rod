import Foundation
let r=arc4random_uniform(101)
print("Guess a number 0 to 100")
for i in stride(from:6,to:-1,by:-1){let t=Int(readLine() ?? "") ?? 0
if t==r{print("You won")}else if t>r{print("Less than \(t), \(i) tries left")}else{print("Greater than \(t), \(i) tries left")}
if t==r{break}else if(i==0){print("You lost")}}

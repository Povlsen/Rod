//
//  main.swift
//  Projekt
//
//  Created by elev on 23/04/2018.
//  Copyright © 2018 Nikolai Povlsen. All rights reserved.
//

import Foundation

/*********************************************************************************************************
 Her har jeg lavet de variabler som bliver brugt globalt i de forskellige funktioner, til at holde styr
 på antallet af alt man har
 *********************************************************************************************************/
var wood = 0
var stone = 0
var iron = 0
var gold = 0
var diamond = 0
var healthPoints:Double = 20
var houses = 0

/*********************************************************************************************************
 For overskuelighed i mine structs har jeg valgt at lave en enum type, til de forskellige materialer
 man kan lave værktøjer ud af
 *********************************************************************************************************/
enum Material{
    case hand, wood, stone, iron, gold, diamond
}

/*********************************************************************************************************
 Her har jeg defienret de to structs til værktøjerne man bruger og bygger i programmets løb. Jeg har valgt
 at lave structs for at holde styr på værdier som de forskellige typer af værktjet skal have
 *********************************************************************************************************/
struct Pickaxe{
    var material:Material
    var durability:Int
    var canMineIron:Bool
    var canMineDiamond:Bool
    var speed:Double
    var stoneSpeed:Double
}
struct Axe{
    var material: Material
    var durability:Int
    var speed:Double
}
/*********************************************************************************************************
 For at holde styr på værktøjer og have mit standard "hand" værkstøj har jeg valgt at samle dem i et array
 *********************************************************************************************************/
var pickaxeArray:[Pickaxe] = []
var axeArray:[Axe] = []
var hand = Axe(material: .hand, durability: 0, speed: 4)
axeArray.append(hand)

/*********************************************************************************************************
 chopWood er funktionen man kalder få at få træ. Efter den bliver kaldt bliver der spurgt hvilken Axe
 man vil bruge og dernæst hvor meget træ man kunne tænke sig.
 Herefter kommer man ned i et while loop som kører så længe det ønsket antal træ(bliver trukket en fra pr.
 gang det kører rundt) og healthPoints er over 0, bliver en af disse 0 eller under vil loopet stoppe og
 gå videre til et if-statemnt, som tjekker hvad man løb tør for og printer årsagen til at loopet stoppede.
 Loopet tjekker også durability på den Axe man har valgt(bliver trukket en fra, som ved antal træ),
 og hvis denne løber ud, vil man automatisk bruge hånden, det vil resultere i at der kommer større delay og
 man mister liv
 *********************************************************************************************************/
func chopWood(){
    print("You have to choose an axe")
    print("right now you have these:")

    for index in 1..<axeArray.count {
        print("\(index):", axeArray[index].material, "with \(axeArray[index].durability) durability left")
    }
    print("")
    print("Type the index of the axe you want to use and press enter")
    print("If you do not have any axes yet you can use your hand by pressing enter,")
    print("but be aware, you will loose 0.1 HP for every piece you chop with you hand")
    
    
    let tempAxe = readLine() ?? "" //Hvis der ikke bliver indtastet et input, så kan man lave en standard værdi
    let arrayPosition:Int = Int(tempAxe) ?? 0 //Jeg har valgt standard værdien til at være 0 da, det er der et array starter, så ens "hand" vil blive valgt som standard
    var currentAxe:Axe
    if arrayPosition >= 0 && arrayPosition < axeArray.count{
        currentAxe = axeArray[arrayPosition]
    
        print("How many pieces do you want to chop?")
        print("You have \(wood) pieces of wood right now")
        let temp:String = readLine() ?? ""
        var int:Int = Int(temp) ?? 0
        var funcWood = 0
        while int > 0 && healthPoints > 0{
            wood += 1
            int -= 1
            funcWood += 1
            print("\(funcWood)/\(temp) piece(s) chopped")
            if currentAxe.durability <= 0{
                if currentAxe.durability == 0{
                    print("You ran out of durability on your axe, and is now using your fist")
                }
                print("You will slowly loose health")
                healthPoints -= 0.1
                print("Health \(healthPoints)/20")
                Thread.sleep(forTimeInterval: 3)
            } else {
                Thread.sleep(forTimeInterval: currentAxe.speed)
            }
            currentAxe.durability -= 1
        }
        if currentAxe.durability <= 0 && healthPoints <= 0{
            print("You have collected \(funcWood) pieces of wood, but your axe broke and you started using your hand")
            print("You died of chopping wood, how does that feel?")
        } else if currentAxe.durability <= 0{
            print("You have now collected \(funcWood) pieces of wood, but then your axe broke, but you still have \(healthPoints)/20 health left ")
            if currentAxe.material != .hand{
                axeArray.remove(at: arrayPosition)
            }
            StartScreen()
        } else {
            axeArray[arrayPosition].durability -= funcWood
            print("You have now collected \(funcWood) pieces of wood")
            StartScreen()
        }
    } else {
        print("o-----------------o")
        print("| Invalid input!! |")
        print("o-----------------o")
        chopWood()
    }
}

/*********************************************************************************************************
 mine funktionen starter ud meget ligesom chopWood, men tjekker dog først pickaxeArray for Pickaxes,
 hvis der så er en pickaxe eller flere spørger den om hvilken man vil bruge. I modsætning til chopWood
 bliver man ikke spurgt om hvor meget man vil mine, men bruger istedet alt durability på pickaxen.
 Funktionen fungere ved at der bliver genereret et tilfældigt nummer fra 1 til 3097 og hvis nummeret kan
 divideres med en af chancerne for materialerne andet end sten og give nul i modulu vil man få printet
 en besked hvad man har fundet og tilføje 1 til den globale materiale variablen.
 Jeg har også tilføjet lidt visuelt for wood, stone og gold pickaxes, så man ikke tror koden er gået i stå.
 *********************************************************************************************************/
func mine(){ //
    if pickaxeArray.isEmpty{ //For at være sikker på at man har noget at mine med tjekker jeg først om pickaxeArray er tomt eller ej
        print("You do not have any pickaxes. Go chop some wood and make a wood pickaxe")
        StartScreen()
    } else {
        print("You have to choose an pickaxe")
        print("right now you have these:")
        var index = 0
        for pickaxe in pickaxeArray{
            print("\(index):", pickaxe.material)
            index += 1
        }
        print("")
        print("Type the index of the pickaxe you want to use and press enter")
        
        let tempPickaxe = readLine() ?? ""
        let arrayPosition:Int = Int(tempPickaxe) ?? 0 // når man kommer her til at man sikker på at der minimum er en ting i arrayet, og hvis man så bare klikker enter ved readLine(), så vil det første objekt blive valgt
        var currentPickaxe:Pickaxe
        if arrayPosition >= 0 && arrayPosition < pickaxeArray.count{ //Her bliver der tjekket at brugeren ikke indtaster en indeksværdi som ikke er i arrayet
            currentPickaxe = pickaxeArray[arrayPosition]
            var mined = 0
            let totalDurability = currentPickaxe.durability
            
            while currentPickaxe.durability > 0{
                let randomNumber = arc4random_uniform(3097)
                if randomNumber % 3097 == 0 && currentPickaxe.canMineDiamond{ //Chancen for at finde diamant
                    diamond += 1
                    print("WOW! You found a diamond!, you now have \(diamond) diamonds in your inventory")
                    Thread.sleep(forTimeInterval: currentPickaxe.speed)
                } else if randomNumber % 1160 == 0 && currentPickaxe.canMineDiamond{ //Chancen for at finde guld
                    gold += 1
                    print("WOW! You found gold!, you now have \(gold) gold in your inventory")
                    Thread.sleep(forTimeInterval: currentPickaxe.speed)
                } else if (randomNumber % 232 == 0 && currentPickaxe.canMineIron){ //Chancen for at finde jern
                    iron += 1
                    print("WOW! You found iron!, you now have \(iron) iron in your inventory")
                    Thread.sleep(forTimeInterval: currentPickaxe.speed)
                } else { //Hvis random tallet ikke er chancen for at finde andre materialer eller ikke kan mine de andre materialer, vil man få sten
                    if !currentPickaxe.canMineIron && !currentPickaxe.canMineDiamond{ //For de to pickaxes som ikke kan mine andet end sten har jeg tilføjet lidt visuelt, så brugeren ikke tror programmet er gået i stå
                        print("\(mined)/\(totalDurability) is mined")
                    }
                    
                    stone += 1
                    Thread.sleep(forTimeInterval: currentPickaxe.stoneSpeed)
                }
                currentPickaxe.durability -= 1
                mined += 1
                if mined % 10 == 0{ //Da der kan gå lang mellem materialerne, har jeg igen tilføjet lidt visuelt så brugeren ikke mistænker at programmet er gået i stå
                    print("Mining...")
                }
            }
            print("Stone: ",stone, " Iron: ",iron, " Gold: ",gold," Diamond: ", diamond)
            pickaxeArray.remove(at: arrayPosition)
            StartScreen()
        } else { //For ikke at få errors hvis brugeren indtaster et nummer som ikke er i arrayet, printer jeg lige en lille meddelse og går tilbage til starten af funktionen
            print("o-----------------o")
            print("| Invalid input!! |")
            print("o-----------------o")
            mine()
        }
    }
}

/*********************************************************************************************************
 Her har jeg lavet et switch statement hvor brugeren får lov til vælge hvad der skal laves af materialerne
 *********************************************************************************************************/
func craft(){
    print("""
        o----------------------------o
        | What do you want to craft? |
        | 1: A house (250w, 1000s)   |
        | 2: A pickaxe               |
        | 3: An axe                  |
        o----------------------------o
        """)
    let response: String? = readLine()
    switch response{
    case "1"?:
        buildHouse()
    case "2"?:
        craftPickaxe()
    case "3"?:
        craftAxe()
    default:
        StartScreen()
    }
}

/*********************************************************************************************************
 Igen her bliver der brugt et switch statement så brugeren selv kan vælge hvad der bliver lavet
 i selve statementet bliver der så tjekket om brugeren har indsamlet nok materialer til at lave pickaxen,
 hvis brugeren har nok materialer, bliver det antallet trukket fra og en pickaxe vil blive tilføjet til
 et array
 *********************************************************************************************************/
func craftPickaxe(){
    print("""
        o--------------------------------------------------------o
        | What material do you want to craft a pickaxe with?     |
        | You will need 3 pieces of the type and 1 piece of wood |
        | 1: Wood                                                |
        | 2: Stone                                               |
        | 3: Iron                                                |
        | 4: Gold                                                |
        | 5: Diamond                                             |
        o--------------------------------------------------------o
        """)
    let response:String? = readLine()
    switch response {
    case "1"?: // Wood
        if wood >= 4{
            wood -= 1
            wood -= 3
            pickaxeArray.append(Pickaxe(material: .wood, durability: 60, canMineIron: false, canMineDiamond: false, speed: 1.15, stoneSpeed: 1.15))
        } else {
            print("You do not have enough materials to craft a wood pickaxe")
        }
        StartScreen()
    case "2"?: // Stone
        if wood >= 1 && stone >= 3{
            wood -= 1
            stone -= 3
            pickaxeArray.append(Pickaxe(material: .stone, durability: 132, canMineIron: true, canMineDiamond: false, speed: 1.15, stoneSpeed: 0.6))
        } else {
            print("You do not have enough materials to craft a stone pickaxe")
        }
        StartScreen()
    case "3"?: // Iron
        if wood >= 1 && iron >= 3{
            wood -= 1
            iron -= 3
            pickaxeArray.append(Pickaxe(material: .iron, durability: 251, canMineIron: true, canMineDiamond: true, speed: 0.75, stoneSpeed: 0.4))
        }else {
            print("You do not have enough materials to craft a iron pickaxe")
        }
        StartScreen()
    case "4"?: // Gold
        if wood >= 1 && gold >= 3{
            wood -= 1
            gold -= 3
            pickaxeArray.append(Pickaxe(material: .gold, durability: 33, canMineIron: false, canMineDiamond: false, speed: 0.2, stoneSpeed: 0.2))
        } else {
            print("You do not have enough materials to craft a gold pickaxe")
        }
        StartScreen()
    case "5"?: // Diamond
        if wood >= 1 && diamond >= 3{
            wood -= 1
            diamond -= 3
            pickaxeArray.append(Pickaxe(material: .diamond, durability: 1562, canMineIron: true, canMineDiamond: true, speed: 0.6, stoneSpeed: 0.3))
        } else {
            print("You do not have enough materials to craft a diamond pickaxe")
        }
        StartScreen()
    default:
        print("That was not an option")
        craftPickaxe()
    }
}

/*********************************************************************************************************
 Ligeledes med craftPickaxe funktionen, bliver der tjekket hvad brugeren indtaster og hvor mange materialer,
 brugeren har
 *********************************************************************************************************/
func craftAxe(){
    print("""
        o--------------------------------------------------------o
        | What material do you want to craft a axe with?         |
        | You will need 3 pieces of the type and 1 piece of wood |
        | 1: Wood                                                |
        | 2: Stone                                               |
        | 3: Iron                                                |
        | 4: Gold                                                |
        | 5: Diamond                                             |
        o--------------------------------------------------------o
        """)
    let response:String? = readLine()
    switch response {
    case "1"?: // Wood
        if wood >= 4{
            wood -= 1
            wood -= 3
            axeArray.append(Axe(material: .wood, durability: 60, speed: 1.5))
        } else {
            print("You do not have enough materials to craft a wood axe")
        }
        StartScreen()
    case "2"?: // Stone
        if wood >= 1 && stone >= 3{
            wood -= 1
            stone -= 3
            axeArray.append(Axe(material: .stone, durability: 132, speed: 0.75))
        } else {
            print("You do not have enough materials to craft a stone axe")
        }
        StartScreen()
    case "3"?: // Iron
        if wood >= 1 && iron >= 3{
            wood -= 1
            iron -= 3
            axeArray.append(Axe(material: .iron, durability: 251, speed: 0.5))
        }else {
            print("You do not have enough materials to craft a iron axe")
        }
        StartScreen()
    case "4"?: // Gold
        if wood >= 1 && gold >= 3{
            wood -= 1
            gold -= 3
            axeArray.append(Axe(material: .gold, durability: 33, speed: 0.25))
        } else {
            print("You do not have enough materials to craft a gold axe")
        }
        StartScreen()
    case "5"?: // Diamond
        if wood >= 1 && diamond >= 3{
            wood -= 1
            diamond -= 3
            axeArray.append(Axe(material: .diamond, durability: 1562, speed: 0.4))
        } else {
            print("You do not have enough materials to craft a diamond axe")
        }
        StartScreen()
    default:
        print("That was not an option")
        craftPickaxe()
    }
}

/*********************************************************************************************************
 Bare for at lave lidt andet content ved spillet kan man bygge et hus, og på sammen vis som de andre "craft"
 funktioner bliver der tjekket om der er nok materialer til det, som derefter bliver trukket fra
 *********************************************************************************************************/
func buildHouse(){
    if wood >= 250 && stone >= 1000{
        print("")
        print("You now have a new house")
        print("")
        wood -= 250
        stone -= 1000
    } else {
        print("You do not have enough materials")
        StartScreen()
    }
    houses += 1
}

/*********************************************************************************************************
 For at sselv kunne holde styr på hvor meget man har af forskellige ting, har jeg lavet denne funktion
 som printer materialerne, udstyret og husene man har fået skaffet sig i løbet af spillets forløb
 *********************************************************************************************************/
func showInv (){
    print("""
        Your inventory contains:
        Wood: \(wood)
        Stone: \(stone)
        Iron: \(iron)
        Gold: \(gold)
        Diamond: \(diamond)
        """)
    print("You have pickaxes made of:")
    var indexPickaxe = 0
    for pickaxe in pickaxeArray{
        indexPickaxe += 1
        print("\(indexPickaxe):",pickaxe.material)
    }
    print("You have axes made of:")
    for index in 1..<axeArray.count {
        print("\(index):", axeArray[index].material)
    }
    
    print("")
    print("Beside all that you have build \(houses) house(s)")
    StartScreen()
}

/*********************************************************************************************************
 Her er selve hoved elementet ved spillet som er den standard menu som man automatisk vender tilbage til
 efter at have udført en handling, så længe man har healthPoints tilbage. Funktionen er sat op med et
 switch statement som kalder de andre funtionerne ovenfor.
 *********************************************************************************************************/
func StartScreen(){
    print("o--------------------o")
    print("| Terminal Minecraft |")
    print("| Choose your action |")
    print("| 1: Chop wood       |")
    print("| 2: Craft           |")
    print("| 3: Mine            |")
    print("| 4: Show invertory  |")
    print("o--------------------o")
        
    let response: String? = readLine()
    //Switchstatement to start menu
    switch response{
    case "1"?:
        chopWood()
    case "2"?:
        craft()
    case "3"?:
        mine()
    case "4"?:
        showInv()
    default:
        print("You must choose a action")
        StartScreen()
        
    }
}
StartScreen()


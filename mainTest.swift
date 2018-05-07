//
//  main.swift
//  Star Survival
//
//  Created by Emil Neirup Jensen on 2/05/2018.
//  Copyright © 2018 Emil Neirup Jensen. All rights reserved.
//

import Foundation

// Struct for hvad et rum kan indeholde
struct Room {
    var monster: Int
    var chest: Int
    var chestStar: Int
    var chestBandage: Int
    var chestKey: Int
    //var hasBeenOpenBefore: Bool
}

//Funktionen som starter spillet, kaldes først til aller sidst, samt hvis en spiller er død, og vil starte forfra.
func startGame(){
    
    // Definerer start værdierne på liv, nøgler og sjerner
    var health = 100
    var keys = 2
    var starsCollecet = 0
    
    //Funktion til at printe liv, nøgler og stjerner
    func collections(){
        print("\n\n\n❤️: \(health)\n🗝: \(keys)\n⭐️: \(starsCollecet)")
    }
    
    //Funktion som tjekker om spilleren er død, efter der åbnes et rum
    func isHeDead(){
        if health < 1 {
            print("\nYou are dead - Do you want to play again?\n type r to restart")
            collections()
            if "r" == readLine(){
                startGame() //Starter spillet forfra, hvis spilleren er død
            }
        }
    }
    
    //Funktion som tjekker om spilleren har flere nøgler, efter der bruges en nøgle
    func hasKeys(){
        if keys < 1 {
            print("You ran out of keys, and havnt collect all 3 stars\nDo you want to play again?\n\n type r to restart")
            if "r" == readLine(){
                startGame() //Starter spillet forfra, hvis spilleren er død
            }
        }
    }
    
    //Funktion som tjekker om spilleren har fundet alle tre stjerner, efter der opsamles en stjerne
    func needMoreStars(){
        if starsCollecet == 3 {
            print("Congrats - You have collecte all tree stars\n\nDo you want to play again? type r to restat")
            if "r" == readLine(){
                startGame() //Starter spillet forfra, hvis spilleren vil prøve igen
            }
        }
    }
    
    //Variabler som indikerer om et rum har været åbnet før
    var room1HasBeenOpen = false
    var room2HasBeenOpen = false
    var room3HasBeenOpen = false
    var room4HasBeenOpen = false
    var room5HasBeenOpen = false
    
    
    
    print("Welcom to Star Survival!\n\nThis is a collection game, where you walk through differences rooms, and collect stars.\nTo win this game, you need to collect 3 stars.\nBut be prepared, monster lives in some rooms, and they will damage your health!\nYour health, money, keys, and start collecet will allways be shown.")
    print("\nType 0 - to begin\n")
    
    //Hvis der tastes '0' starter spillet
    if let typed = readLine() {
        if let numTypedToBegin = Int(typed){    // Laver readLine() om til en INT, så det kan se om der er intastet '0'
            if numTypedToBegin == 0{
                print("The game has begin.\n\nYou stand in a lobby, and have 5 doors in front of you. The doors are numbered 1 to 5\n")
                
                //Så længe health er større end 0, kører dette program.
                while health > 0 {
                    
                    //Funktionen hvor spilleren står i lobbyen og kan vælge imellem de 5 rum.
                    func lobby() {
                        print("\nTo open a door, you need to use a key.\nBut be prepared, if the room contains a monster, it will damage your health with 50. A bandage will help, if a monster has damage you.\nYou can only enter a room once, so think about in which order you open the rooms.\n\n Which door do you want to open?\n\nType a number between 1 and 5")
                        collections()   //Viser liv, nøgler og stjerner
                        
                        //Funktion som tager det indtastet tal og laver det til en Int, således det kan bruges i en Switch Case senere.
                        //Nummeret indikerer hvilet rum, spilleren vil åbne.
                        func chooseRoomNumber(){
                            if let typed1 = readLine() {
                                if let numTypedToChooseRoom = Int(typed1){
                                    
                                    switch numTypedToChooseRoom {
                                    case 1: //Rum nr. 1 åbnes.
                                        if room1HasBeenOpen == true {   //Der tjekkes om rummet har været åbent før.
                                            print("This room has been open once, choos another room")   //Hvis de har været åbent før, bliver spilleren bedt om at gå til lobby
                                            print("Return to lobby, by typing r")
                                            if "r" == readLine() {
                                                lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                            }
                                            else {
                                                print("Please type r to return to lobby")
                                                if "r" == readLine() {
                                                    lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                                }
                                            }
                                        }
                                        keys -= 1
                                        print("\nYou are now in room number 1")
                                        collections()   //Viser liv, nøgler og stjerner.
                                        hasKeys()   //Tjekker om spilleren har flere nøgler.
                                        room1HasBeenOpen = true //Markere at spilleren har været inde i rummet, og kan derfor ikke åbnes igen.
                                        let roomCertains = Room(monster: 1, chest: 1, chestStar: 1, chestBandage: 0, chestKey: 7)   //Henter Structen som viser hvad et rum kan indeholde. - Der gives værdier
                                        print("\nThis Room contains \(roomCertains.monster) monster and \(roomCertains.chest) chest")
                                        if roomCertains.monster == 1 {     //Hvis rummet har et monster fjernes der 50 fra liv.
                                            health -= 50
                                            print("\nYou killed the monster, but your health was damage by 50")
                                            isHeDead()  //Der tjekkes om spilleren har mere liv
                                        }
                                        if roomCertains.chest == 1 {    //Hvis rummet har en kiste, skal den åbnes med 'y'.
                                            print("\nUse a key, and open the chest by typing y")
                                            if "y" == readLine(){
                                                keys -= 1      //Der bruges en nøgle på at åbne kisten
                                                print("\nIn This chest you have collecet \(roomCertains.chestStar) star,\(roomCertains.chestKey) keys and \(roomCertains.chestBandage) bandage form the chest.")
                                                keys += roomCertains.chestKey //Der opsamles nøgler fra kisten, så de vises i collection
                                                starsCollecet += roomCertains.chestStar //Der opsamles stjerne fra kisten, så de vises i collection
                                                collections()   //Viser liv, stjerne og nøgler
                                                hasKeys()   //Tjekker om spilleren har flere nøgler
                                                needMoreStars() //Tjekker om spilleren har fundet alle stjerner
                                                print("Return to lobby, by typing r")
                                                if "r" == readLine() {
                                                    lobby()
                                                }
                                                else {
                                                    print("Please type r to return to lobby")
                                                    if "r" == readLine() {
                                                        lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                                    }
                                                }
                                            }
                                            else {
                                                print("Please type y (yes)")
                                            }
                                        }
                                        
                                    case 2: //Rum nr. 2 åbnes.
                                        if room2HasBeenOpen == true { //Der tjekkes om rummet har været åbent før.
                                            print("This room has been open once, choos another room") //Hvis de har været åbent før, bliver spilleren bedt om at gå til lobby
                                            print("Return to lobby, by typing r")
                                            if "r" == readLine() {
                                                lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                            }
                                        }
                                        keys -= 1
                                        print("\nYou are now in room number 2")
                                        collections()   //Viser liv, nøgler og stjerner.
                                        hasKeys()   //Tjekker om spilleren har flere nøgler.
                                        let roomCertains = Room(monster: 0, chest: 1, chestStar: 0, chestBandage: 1, chestKey: 0)
                                        print("\nThis Room contains \(roomCertains.monster) monster and \(roomCertains.chest) chest")
                                        if roomCertains.monster == 1 {
                                            health -= 50
                                            print("\nYou killed the monster, but your health was damage by 50")
                                            isHeDead()
                                        }
                                        room2HasBeenOpen = true //Markere at spilleren har været inde i rummet, og kan derfor ikke åbnes igen.
                                        if roomCertains.chest == 1 {    //Hvis rummet har en kiste, skal den åbnes med 'y'.
                                            print("\nUse a key, and open the chest by typing y")
                                            if "y" == readLine(){
                                                keys -= 1   //Der bruges en nøgle på at åbne kisten
                                                collections()
                                                hasKeys()
                                                print("\nIn This chest you have collecet \(roomCertains.chestStar) star,\(roomCertains.chestKey) keys and \(roomCertains.chestBandage) bandage form the chest.")
                                                keys += roomCertains.chestKey //Der opsamles nøgler fra kisten, så de vises i collection
                                                starsCollecet += roomCertains.chestStar //Der opsamles stjerner fra kisten, så de vises i collection
                                                if roomCertains.chestBandage == 1 {
                                                    health += 40    //Der opslamles bandage, som forhøjer health med 40
                                                }
                                                collections()   //Viser liv, stjerne og nøgler
                                                hasKeys()   //Tjekker om spilleren har flere nøgler
                                                needMoreStars() //Tjekker om spilleren har fundet alle stjerner
                                                print("Return to lobby, by typing r")
                                                if "r" == readLine() {
                                                    lobby()
                                                }
                                                else {
                                                    print("Please type r to return to lobby")
                                                    if "r" == readLine() {
                                                        lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                                    }
                                                }
                                            }
                                            else if "y" != readLine(){
                                                print("Please type y (yes)")
                                            }
                                        }
                                        
                                    case 3: //Rum nr. 3 åbnes.
                                        if room3HasBeenOpen == true {   //Der tjekkes om rummet har været åbent før.
                                            print("This room has been open once, choos another room")   //Hvis de har været åbent før, bliver spilleren bedt om at gå til lobby
                                            print("Return to lobby, by typing r")
                                            if "r" == readLine() {
                                                lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                            }
                                        }
                                        keys -= 1
                                        print("\nYou are now in room number 3")
                                        collections()   //Viser liv, nøgler og stjerner.
                                        hasKeys()   //Tjekker om spilleren har flere nøgler.
                                        let roomCertains = Room(monster: 1, chest: 1, chestStar: 1, chestBandage: 0, chestKey: 0)
                                        print("\nThis Room contains \(roomCertains.monster) monster and \(roomCertains.chest) chest")
                                        if roomCertains.monster == 1 {
                                            health -= 50
                                            print("\nYou killed the monster, but your health was damage by 50")
                                            isHeDead()
                                        }
                                        room3HasBeenOpen = true //Markere at spilleren har været inde i rummet, og kan derfor ikke åbnes igen.
                                        if roomCertains.chest == 1 {    //Hvis rummet har en kiste, skal den åbnes med 'y'.
                                            print("\nUse a key, and open the chest by typing y")
                                            if "y" == readLine(){
                                                keys -= 1   //Der bruges en nøgle på at åbne kisten
                                                collections()
                                                hasKeys()
                                                print("\nIn This chest you have collecet \(roomCertains.chestStar) star,\(roomCertains.chestKey) keys and \(roomCertains.chestBandage) bandage form the chest.")
                                                keys += roomCertains.chestKey //Der opsamles nøgler fra kisten, så de vises i collection
                                                starsCollecet += roomCertains.chestStar //Der opsamles stjerner fra kisten, så de vises i collection
                                                if roomCertains.chestBandage == 1 {
                                                    health += 40    //Der opslamles bandage, som forhøjer health med 40
                                                }
                                                collections()   //Viser liv, stjerne og nøgler
                                                hasKeys()   //Tjekker om spilleren har flere nøgler
                                                needMoreStars() //Tjekker om spilleren har fundet alle stjerner
                                                print("Return to lobby, by typing r")
                                                if "r" == readLine() {
                                                    lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                                }
                                            }
                                            else if "y" != readLine(){
                                                print("Please type y (yes)")
                                            }
                                        }
                                        
                                    case 4: //Rum nr. 4 åbnes.
                                        if room4HasBeenOpen == true {   //Der tjekkes om rummet har været åbent før.
                                            print("This room has been open once, choos another room")   //Hvis de har været åbent før, bliver spilleren bedt om at gå til lobby
                                            print("Return to lobby, by typing r")
                                            if "r" == readLine() {
                                                lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                            }
                                        }
                                        keys -= 1
                                        print("\nYou are now in room number 4")
                                        collections()   //Viser liv, nøgler og stjerner.
                                        hasKeys()   //Tjekker om spilleren har flere nøgler.
                                        let roomCertains = Room(monster: 1, chest: 0, chestStar: 0, chestBandage: 0, chestKey: 0)
                                        print("\nThis Room contains \(roomCertains.monster) monster and \(roomCertains.chest) chest")
                                        if roomCertains.monster == 1 {
                                            health -= 50
                                            print("\nYou killed the monster, but your health was damage by 50")
                                            isHeDead()
                                        }
                                        room4HasBeenOpen = true //Markere at spilleren har været inde i rummet, og kan derfor ikke åbnes igen.
                                        if roomCertains.chest == 1 {    //Hvis rummet har en kiste, skal den åbnes med 'y'.
                                            print("\nUse a key, and open the chest by typing y")
                                            if "y" == readLine(){
                                                keys -= 1   //Der bruges en nøgle på at åbne kisten
                                                collections()
                                                hasKeys()
                                                print("\nIn This chest you have collecet \(roomCertains.chestStar) star,\(roomCertains.chestKey) keys and \(roomCertains.chestBandage) bandage form the chest.")
                                                keys += roomCertains.chestKey   //Der opsamles nøgler fra kisten, så de vises i collection
                                                starsCollecet += roomCertains.chestStar //Der opsamles stjerner fra kisten, så de vises i collection
                                                if roomCertains.chestBandage == 1 {
                                                    health += 40    //Der opslamles bandage, som forhøjer health med 40
                                                }
                                                collections()   //Viser liv, stjerne og nøgler
                                                hasKeys()   //Tjekker om spilleren har flere nøgler
                                                needMoreStars() //Tjekker om spilleren har fundet alle stjerner
                                                print("Return to lobby, by typing r")
                                                if "r" == readLine() {
                                                    lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                                }
                                            }
                                                
                                            else if "y" != readLine(){
                                                print("Please type y (yes)")
                                            }
                                        }
                                        
                                    case 5: //Rum nr. 5 åbnes.
                                        if room5HasBeenOpen == true { //Der tjekkes om rummet har været åbent før.
                                            print("This room has been open once, choos another room") //Hvis de har været åbent før, bliver spilleren bedt om at gå til lobby
                                            print("Return to lobby, by typing r")
                                            if "r" == readLine() {
                                                lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                            }
                                        }
                                        keys -= 1
                                        print("\nYou are now in room number 5")
                                        collections()   //Viser liv, nøgler og stjerner.
                                        hasKeys()   //Tjekker om spilleren har flere nøgler.
                                        let roomCertains = Room(monster: 0, chest: 1, chestStar: 1, chestBandage: 0, chestKey: 0)
                                        print("\nThis Room contains \(roomCertains.monster) monster and \(roomCertains.chest) chest")
                                        if roomCertains.monster == 1 {
                                            health -= 50
                                            print("\nYou killed the monster, but your health was damage by 50")
                                            isHeDead()
                                        }
                                        room5HasBeenOpen = true //Markere at spilleren har været inde i rummet, og kan derfor ikke åbnes igen.
                                        if roomCertains.chest == 1 {    //Hvis rummet har en kiste, skal den åbnes med 'y'.
                                            print("\nUse a key, and open the chest by typing y")
                                            if "y" == readLine(){
                                                keys -= 1   //Der bruges en nøgle på at åbne kisten
                                                collections()
                                                hasKeys()
                                                print("\nIn This chest you have collecet \(roomCertains.chestStar) star,\(roomCertains.chestKey) keys and \(roomCertains.chestBandage) bandage form the chest.")
                                                keys += roomCertains.chestKey   //Der opsamles nøgler fra kisten, så de vises i collection
                                                starsCollecet += roomCertains.chestStar //Der opsamles stjerner fra kisten, så de vises i collection
                                                if roomCertains.chestBandage == 1 {
                                                    health += 40    //Der opslamles bandage, som forhøjer health med 40
                                                }
                                                collections()   //Viser liv, stjerne og nøgler
                                                hasKeys()   //Tjekker om spilleren har flere nøgler
                                                needMoreStars() //Tjekker om spilleren har fundet alle stjerner
                                                print("Return to lobby, by typing r")
                                                if "r" == readLine() {
                                                    lobby() //Går tilbage til lobby, så spilleren kan vælge et ny rum.
                                                }
                                            }
                                            else if "y" != readLine(){
                                                print("Please type y (yes)")
                                            }
                                        }
                                        
                                    default:
                                        print("\nYou didnt type a valid number!\nPlease type a number between 1 and 5")
                                        chooseRoomNumber()
                                    }
                                }
                            }
                        }
                        chooseRoomNumber()
                    }
                    lobby()
                }
                print("You're Dead")
            }
        }
    }
}
startGame()


//
//  PersonController.swift
//  FoundersDirectory
//
//  Created by AJ Bronson on 9/15/16.
//  Copyright © 2016 PrecisionCodes. All rights reserved.
//

import UIKit


class PersonController {
    
    static let shared = PersonController()
    
    //MARK: - Properties
    
    var people: [Person]
    
    var me: Person = Person(firstName: "AJ", lastName: "Bronson", photo: "person0", companyName: "iOS Developer", phone: "888-888-8888", email: "bronson109@hotmail.com", spouseName: "MyDarling", status: Status.gold, businessProfile: "Hi, my name is AJ Bronson, and I'm an iOS developer!  I've been enjoying programming for several years, and would love to meet you for lunch sometime! Contact me by email to set up an appointment.")
    
    //MARK: - Initializer
    
    init() {
        //Create 6 dummy data people for testing purposes
        let person1 = Person(firstName: "John", lastName: "Doe", photo: "person1", companyName: "eNex Solutions", phone: "801-447-2315", email: "johndoe@gmail.com", spouseName: "Angela", status: Status.bronze, businessProfile: "eNex Solutions is a fantastic company that does software development.  I have worked here for seventeen years, and am completely happy.  We get cool things, like $30,000 salaries, and three days off per year.  How could life get any better than this? To work here, contact me via phone or email.")
        let person2 = Person(firstName: "Adam", lastName: "Smith", photo: "person2", companyName: "Rocker Wallz", phone: "844-253-6432", email: "asmi@msnmessenger.com", spouseName: "Rick", status: Status.gold, businessProfile: "I started this company when I was in middle school. It's a great place to work, and I love all of my employees.  We do rock climbing events all over the state of Utah.  Our big business is from schools and carnivals. Contact us to hire us for your next event!")
        let person3 = Person(firstName: "Amy", lastName: "Stevens", photo: "person3", companyName: "Rich Mixes", phone: "377-234-6523", email: "a@mix.com", spouseName: "Harvey", status: Status.silver, businessProfile: "Rich Mixes makes a bunch of delicious treats.  We have customized recipies for brownies, cookies, shakes, and more!  Buy one of my books from my website richmixes.com.  I promise that you won't be disappointed!!")
        let person4 = Person(firstName: "Stephanie", lastName: "Wickens", photo: "person4", companyName: "Consumer Report Maniac", phone: "801-234-6322", email: "crm@crm.com", spouseName: "Yaci", status: Status.gold, businessProfile: "Hi, I am one of the founders of the Founders Directory.  We really hope you enjoy your experience here. I get side-tracked easily. I like chocolate too. Maybe I'll buy a mix from Amy. But anyways, what was I saying? Oh ya! The consumer report maniac is something that I've been doing for years.  Also, if you need your photo professionally taken, my sister is in the busines! Thanks y'all!", phoneHidden: true)
        let person5 = Person(firstName: "Bobby", lastName: "Bobbertson", photo: "person5", companyName: "Bob's bobbies", phone: "801-300-2532", email: "bb@bobert.com", spouseName: "Bonnie", status: Status.bronze, businessProfile: "My name is Bob Bobbertson, and my wife, Bonnie Bobbertson is a co-founder in Bob's bobbies.  We make bobby pins for any use.  We like to call them any use bobbies when we're feeling extra spunky.  Bob's bobbies have been dominating the market for years and years, and they are great for hair, extra power cords, and clothes hangers.  Purchase them in bulk by contacting Bonnie Bobbertson or myself, Bob Bobbertson.")
        let person6 = Person(firstName: "Master", lastName: "Chief", photo: "person6", companyName: "Halo 5", phone: "999-777-5555", email: "mchief@kickbutt.com", spouseName: "Cortana", status: Status.gold, businessProfile: "You know who I am.", emailHidden: true, phoneHidden: true)
        
        //Add the 6 person objects to the people array
        people = [person1, person2, person3, person4, person5, person6]
    }
    
    //MARK: - Helper Methods
    
    //Update the "Me" attributes with the edited version
    func updateMe(firstName: String, lastName: String, photo: UIImage, companyName: String, phone: String, email: String, spouseName: String, businessProfile: String, emailHidden: Bool, phoneHidden: Bool) {
        me.firstName = firstName
        me.lastName = lastName
        me.photo = photo
        me.companyName = companyName
        me.phone = phone
        me.email = email
        me.spouseName = spouseName
        me.businessProfile = businessProfile
        me.emailHidden = emailHidden
        me.phoneHidden = phoneHidden
    }
    
}

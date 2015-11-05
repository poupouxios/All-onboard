# All-onboard
Hack Manchester App 2015. I built the iOS app where my other 2 collegaues prepared the back end API in Elixir Phoenix Framework. The app was on the 3 finalists of rentalcars.com and on the 3 finalists of The Barclays/Rise Challenge. We won the competition of The The Barclays/Rise Challenge - Create the best use of beacons for the Rise community.

You can see the results as below:
  - https://youtu.be/YvBy7DBaesk?t=1247 we are on the final 3 for rentalcars.com
  - https://youtu.be/YvBy7DBaesk?t=2188 we are again on final 3 and win the big prizes

# Description

This is an iOS app for on-boarding people who have just rented a car.  The app uses iBeacons to determine the make and model of the car and provides useful information in your language about it (where are the lights / wind screen wipers, what sort of fuel it takes) and puts you in quick contact with other people who have recently rented this type of car if you have any questions.  

Its using Elixir Phoenix framework as a back end API to get the data for the cars. It also is being used to communicate through a chat server on the phone. The project for the Back End can be found here https://github.com/northerner/all_onboard

The app is being written on Objective C and uses various Pods for styling, monitoring beacons, database storage etc.

# Installation

To run the app you need to :
  - pod install
  - Open the pod generated project file
  - You will need to run the Elixir Back End API and get a localhost url
  - Replace in AOBConfig.m the kApiUrl with your localhost url
  - Run the app

You can have a preview of the app on this link https://www.youtube.com/watch?v=azep6YQy2Io

Thanks :)

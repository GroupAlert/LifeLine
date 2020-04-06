LifeLine - README 
===

## Lifeline, the line to stay connected with the important people in your life

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
LifeLine is an app where users are able to see where groups of people are on a map and be alerted if they have been in a accident. The app allows for group admins to set restrictions for group members such as geofencing and speeding.

### App Evaluation

- **Category: Lifestyle** 
- **Mobile: iOS android to come soon**
- **Story: See where your friends and family are**
- **Market: Familes, companies and friends can all use this app to see where each other are and how they are driving**
- **Habit: This app runs in the background and you would open it to see where someone is or check alerts of someone driving too fast or getting into an accident**
- **Scope: We are aiming this at all age groups. Families  can use this to keep track of teens and elder family members. Companies can use this to keep track of delivery workers to hold people accountable. Our main goal is to be the preferred driving behavior and location app**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* As a dad I want to know when my child leaves the curfew radius to know if they are somewhere they shouldn't be
* As a mom I want to know where my children are on the map to know they got to the destination safe
* As a friend I want to see when my friends are speeding to tell them to drive responsibly

**Optional Nice-to-have Stories**

* As a parent I want to be notified if my child is texting and driving so I can tell them not to text and drive.
* As a business owner I want to be alerted when my delivery driver goes off route so I can make sure my drivers are working.
* As a granddaughter I want to see when my grandmother's phone is on low batery so I can remind her to charge it.

### 2. Screen Archetypes

* Login Screen
   * user can sign up 
   * user can log in
* Account Settings Screen
   * user can edit their account information
   * user can log out
   * user can delete their account
* Groups Screen
   * user can create groups
   * user can invite other users 
   * user can edit other users' roles
   * user can edit groups
* Maps Screen
    * user can see people on the map
    * user can filter by group


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* groups tap
* setting tab
* map tab


**Flow Navigation** (Screen to Screen)

* <img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_SignUp_SignIn.png" width=250><br>
   * Signup/SignIn screen; Displays logo with splash page. Ability to SignUp for service or Log in to an account.
* <img src="https://github.com/GroupAlert/LifeLine/blob/master/LL_Profile_Contacts.png" width=250><br>
   * User Profile screen; Displays user information with profile image, countdown timer edit function, and user contacts editing    function.
* <img src="https://github.com/GroupAlert/LifeLine/blob/master/LL_MapDisplay.png" width=250><br>
   * Map screen; Displays current location of user. With Search function, user can locate those in their contacts list.
* <img src="https://github.com/GroupAlert/LifeLine/blob/master/LL_Countdown.png" width=250><br>
   * Countdown screen; Countdown appears after a sufficient impact, and will cycle down then alert those nearby for assitance unless the stop button is used to negate the countdown.

## Wireframes
<img src="https://github.com/GroupAlert/Documentation/blob/master/LifeLine%20Mockup.png" width=250>
<img src="https://github.com/GroupAlert/Documentation/blob/master/wireframe.png" width=250>
<img src="https://github.com/GroupAlert/Documentation/blob/master/LifeLine.gif" width=250><br>
https://www.figma.com/proto/jE3KKpTsZBvMxOezelbsN7/LifeLine?node-id=19%3A3&scaling=scale-down

## Schema 
### Models
Strings, Data var for images to send information.
Dictionaries to recieve information.

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | Name          | String   | User name account|
   | phone number  | String   |  users phone for recovery|
   | Contacts      | Dict     | emergincy contact |
   | image         | png      | image caption by author |
   | commentsCount | Number   | number of comments that has been posted to an image |
   
   
### Networking
- Post user information functions: Windows Server 2019 on AWS, PHP & MySQL
- Read user information functions: Windows Server 2019 on AWS, PHP & MySQL
- Post group information functions: Windows Server 2019 on AWS, PHP & MySQL
- Read group information functions: Windows Server 2019 on AWS, PHP & MySQL
- Post zone information functions: Windows Server 2019 on AWS, PHP & MySQL
- Read zone information functions: Windows Server 2019 on AWS, PHP & MySQL
- http://ec2-54-241-187-187.us-west-1.compute.amazonaws.com/lifeline/testapi.html

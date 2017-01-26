# nearbyRestaurants

## Plataform and Language chosen
This is an application written in swift 2.2 for iOS. I have chosen 2.2 because XCode 7.3.1 is much faster than 8.2. As long as swift 3.0 isn't to diffent from 2.2 and XCode 8.X still too slow, I think is better to use 7.3.1

##Important
You shoulder run "pod install" as soon as you clone the repository, in order to compile it :)

## Highlights of my code writing style
Although this is a short size application, I designed it if I would be developing a much larger application, in order to show how I would like to set up the application classes.

## What I could've been done in a better way
I didn't have any kind of backend server, so I had to improvise and read static json texts. It would be much easier if I had a way to do that with any kind of server. Because this way, actually when the application goes off, the information desappear too.
If I had a server, I would have used the Alamofire lib to make easier and more organized to get the information from the cloud.
So I had to 'fake' everytime I want to send or get a data from server.

Another point is that I'm not a great designer LOL. I understand a lot of things from UX, but I'm really not able to combine colors or things like that, so the application may be 'ugly'.
I wanted to show that I am able to handle localstorage with Realm, but when I realized that I would only use it to store user data, it was too late to user NSUserDefault.

And I would have spent more time making UITests, although the application is not really complicated.

##Final considerations
My main focus was to build a clear code, that is readable even without many comments. Very organized, just the way I would do in a real project.
I wasn't able to spend so many hours in this project, but I've done the best I could'
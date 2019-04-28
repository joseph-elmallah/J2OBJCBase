# J2OBJCBase
A sample base project with J2ObjC setup for using Java code in iOS.

This project is part of a Medium article that you can find here:

This project helps illustrates a starting project with J2ObjC. It has the path correctly setup, the build rules and a sample code that you can replace with your own. The current example is showing how to run a `Game of Life` [Java core by Inoryy](https://github.com/inoryy/game-of-life-java) into an iOS application.

## How to use this project
You need to setup the path to the J2ObjC folder:
- In the Build Settings of the target
- search for `J2OBJC_HOME` key
- replace the value with the actual location of the J2ObjC folder. (Check how to get the J2ObjC folder in my Medium article)

Run the Xcode Project on a device:
- Select a team
- Select a bundle identifier

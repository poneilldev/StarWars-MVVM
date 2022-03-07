# StarWars-MVVM
In this sample app, I use the Star Wars public [api](https://swapi.dev) to show a list of characters from the Star Wars movie series. There are two goals I wish to accomplish with this repository:
1. Show a project that is built with the MVVM architecture design pattern.
2. Add unit tests with XCTest that test more UI logic than before

### MVVM
MVVM stands for `Model View ViewModel`. The view model portion is where state and presentation logic go. Doing so allows the view controller to be basic and simple. The view controller then binds to the view model and does what it's told.

### Testing
MVVM allows us to more fully test the state and presentation logic of the view with just the XCTest framework. Testing UI logic beyond that is normally done by the XCUITest framework. However, with a few tips and tricks in XCTest we can also test things like: 
1. Pushing a view into the view hirearchy
2. Presenting a view

For examples of this see `PersonsViewControllerTests.swift`

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


## Guidelines
### View model should reside in an extension of the view controller it's associated with
```
extension ExampleViewController {
  class ViewModel {
    ...  
  }
}

```

### Use `@Published` over `PassthroughSubject` or `CurrentValueSubject`
 ```
 class ViewModel {
   @Published private(set) var results: [PersonProtocol] = []
   // other variables here
   
   ...
 }
 ```
 - We will be using `@Published` which will act as the publisher for communicating with the view controllers and SwiftUI views. The `@Published` properwrapper is class contrained so the view model must be a class.
 - Since all view model operations are dealing with updating the UI, it is reasonable to have all of our view models be marked with @MainActor. This ensures all attributes and methods called are done so on the main thread.
 - To keep the integrity of the variables in the view model, it is good practice to set them at `private(set)` so that the variables are only able to be set inside the view model. If there is a need to update the values from the view then just create a method with to handle that update and handle all the validation there to safely update the variables.


### We should limit the content of the view model to be: 1) presentation logic and 2) state.

**State**

Generally speaking, there should be no need for the view controller or SwiftUI view to hold variable related to state.

**Presentation Logic**

All presentation logic should reside in the view model. The following are some examples of presentation logic:
1. Calculating data source values of a UITableView/UICollectionView
```
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.getNumPersons()
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier, for: indexPath) as! PersonTableViewCell
    cell.configureCell(self.viewModel.getPerson(for: indexPath))
    return cell
}
```
2. Deciding when the UI should be updated to a different state 

(Example: telling the UI to show a loading indicator)
```
class ViewModel {
  ...

  func loadAllPersons() async throws {
        self.loading = true
        do {
            let persons = try await service.getAllPersons()
            self.results = persons
            self.filteredResults = persons
        } catch let error {
            self.error = error
        }
        self.loading = false
  }
}

```
3. Logic to decide what text should be displayed based on certain conditions

```
class ViewModel {
  ...

  func calculateTitleText() -> String {
      if Date().isWeekDay {
        return NSLocalizedString("Week")
      } else {
        return NSLocalizedString("Weekend")
      }
  }
}
```


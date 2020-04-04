# ECommerceStore For Deloitte

Hi! I'm submitting this for the job application at **Deloitte**.  Before we dig into the code, I would like to explain the project structure and the reasoning behind some of the decisions I took.

# Project Strucure

Once you have the source code checked out, open the **ECommerceStore.xcworkspace** to view all the project dependencies. There are two main targets:

- ECommerceStore (Handles business logic to display UI)
- ECommerceStoreAPI (Handles all the api calls)

## ECommerceStoreAPI

For ease of sharing code, both the ECommerceStore and ECommerceStoreAPI them have been included in the same zip file. However,  ECommerceStoreAPI is configured to be standalone with ability to host it on a separate repository.  

It produces a **ECommerceStoreAPI.framework** which can be embedded into any iOS application and hence gives us the flexibility to reuse it. From a business point of view, splitting this into a separate project helps to have different team working on it or even open source this part internally in the organisation.

The API framework depends on 2 external frameworks - **Nimble** and **Fetch**.

- **Nimble** is a matcher framework which makes unit tests easier to write and understand.
- **Fetch** is lightweight, simple http framework for making api calls. I have deliberately avoided big networking frameworks like Alamofire simply because there wasn't any need for it in this app. 

Both these framework are added via **Carthage** but have been checked in with zip for ease of sharing code. We would add the Carthage checkout and build directory to **.gitignore** otherwise. 

## ECommerceStore

ECommerceStore is the main target for our app which has schemes to run the app, unit tests and ui tests. The code is self explanatory in most places with most of the UI done through storyboards. I haven't tried to pixel perfect everything, as this wasn't the objective of the assignment.  

Out of the 8 stories, I have completed 6 which hopefully should be enough to demonstrate my ability to build mobile applications. You can find UI Tests for each of the stories in the **ECommerceStoreUITests** folder. 

As mentioned in assignment, WishList is persisted on device using **Core Data**. Where as, the product list and cart is fetched from API every time. 

## Unit Tests

There are unit tests for most of the code, both in main project and api project. The unit tests in api project are driven through test data and mocks to remove reliance on network requests. Unit tests for ECommerceStore don't have 100% coverage primarily because those tests are covered by UI Tests.

## UI Tests

UI tests are available for 6 of the stories that were completed. At the moment they point to the same end point as the main app, however in a production app we would ideally have a separate environment where data doesn't change to avoid random failures.

## TODO list

The code is long way from production ready and has few _ToDo_ comments which were not resolved due to time constraints:

- Hardcoded API key - Ideally we don't want to store this in plain text. We want these to be either encrypted or genarated at runtime.
- NSURLComponents - The api url is constructed as string but we would ideally want that to be constructed from standard api
- Print statements - There are bunch of print statements in case error occur. We would want to handle them more gracefully and log them somewhere
- API Models - Most of the properties for **Product** model have been configured to be required parameters for now. We would like them to be optionals in case api changes in future.
- Reachability - We don't check for any network connection loss, which we should.
- Orientation and language support - I have made the application to run only on Potrait orientation to save time and there are no translations supported too. There are also few warnings in storyboard which I have ignored for now.
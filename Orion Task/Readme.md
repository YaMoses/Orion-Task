# Orion Task


## The App

Implemented partial functionality of Safari which includes pages navigation and pages zoom features etc with some assumptions.


## Libraries/Tools used

* No external library was used

## How to setup

1. Download the zip folder.
2. open the folder and click the Orion Task.xcodeproj file.


## Running 

* To run the app simply type "Command + R" in Xcode.

## Features

* Screen contains WKWebview, navigatioon bar, toolbar
* WKWebView is hidden by default after initial app launch and the user should sees a button in the center of the screen
* Tapping this button will start any website load inside WKWebView and will also show WKWebView full screen
* Back/forward actions reflecting an ability for the user to go either back or forward
* Back navigation action allows the user to go from a website loaded in WKWebView to a button in the screen's center.
* Provides interactive horizontal swipe gesture from screen edges to navigate between pages.
* Can save and restore WKWebView navigation history between app launches


## Screenshots

* Entry point of the app at install

<img width="323" alt="Screenshot 2022-09-20 at 17 39 43" src="https://user-images.githubusercontent.com/16121795/191315595-402b4462-39fb-4ad0-96e2-fb9b533bc8c3.png">

* Toolbar area contains back and forward webview navigation buttons and a progress view for when a page is loading
 <img width="327" alt="Screenshot 2022-09-20 at 17 41 29" src="https://user-images.githubusercontent.com/16121795/191315955-26ba831f-94ee-4fe8-819b-6cdff2354dbc.png">

* Swipe action to move back and forth pages. Navigation title changes to the name of the loaded page
<img width="343" alt="Screenshot 2022-09-20 at 17 45 55" src="https://user-images.githubusercontent.com/16121795/191317317-0153cdf4-ef2f-429d-8ce1-c14cf03c0301.png">

* Page zoomed 
<img width="329" alt="Screenshot 2022-09-20 at 17 53 32" src="https://user-images.githubusercontent.com/16121795/191318406-59195e68-006a-466c-858d-5193de97b4bd.png">

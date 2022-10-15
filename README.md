# WatchReader

WatchReader is a book tracking app for watchOS. I'm avid reader and I like to track which book(s) and the progress. There are several options on the market with the most notable being GoodReads. GoodReads has a wealth of data and a well designed UI but GoodReads doesn't have a watchOS app. I like reading before sleep and I usually wear my Apple Watch for sleep tracking so I find it very natural to track the progress directly on my watch. Therefore, I made this app to help keep track of my progress more easily.

# Prequisites

- You will need a macOS machine to work on this repo.
- You will need to have Xcode and Simulator installed.

# Development

- To clone this project, please use the command:
```
git clone git@github.com:hanhqvu/watch-reader.git
```
- Open the project in Xcode
- Press ``CMD + R`` to open a preview of this project

# Tech Stack
- The app used Swift and SwiftUI
- [OpenLibrary API](https://openlibrary.org/developers/api) is used to serve books' data
- [Nuke](https://github.com/kean/Nuke) is used for image caching

# Using

- Currently, the app is not available on the App Store.
- If you are interested in using the app, you will need to build the app your self.
- You can use Xcode to choose your Apple Watch as the build target and
build the app using ``CMD + B``

# License
- This project uses the following license: MIT

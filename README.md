# Garage 🔨🔧🪛🪚🗜


This repository is primarily focused on Swift, iOS, and macOS related code, and is intended to be a hub for sharing and collaborating on new and experimental ideas.

Inside the repository, you'll find a collection of code snippets that showcase new techniques, explore cutting-edge technologies, or simply serve as examples for best practices. These snippets can range in size from just a few lines of code to small projects that demonstrate complete concepts.

Our goal is to create a community where developers can share their ideas, collaborate on projects, and learn from one another. Whether you're a seasoned developer or just starting out, we hope you'll find something useful in this repository.

To get started, simply clone the repository to your local machine and start exploring the code. Feel free to fork the repository and submit pull requests with your own contributions. We welcome all feedback and suggestions, and are always looking for ways to improve the repository and make it more useful to the community.

## Installation

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/jdanek4/garage.git", .branch("main"))
]
```

### Ad-hoc

Clone the repo and copy interesting files and components into your project. Ensure you copy all files and their dependencies.

## Components

### Interface

Library of interesting user interface components and full app screens.

### DateTime

Library for creating, manipulating, and using dates and times.

### Features

Library of app features to enhance applications.

### Persistence

Basic functionality to persist information on disk. Conforming objects to `Storable` interface and extending `StorageManager` to include helper functions for CRUD operations is all you need to do to use.

### Replicates

Recreations of user interfaces in apps or mockups.

## Todo

features
- whats new screen
- feature flags
- analytics
- currency: store value, convert locale, or format display strings

persistence
- store in user defaults, flat file, and cached database

interface
- buttons
- button styles
- emoji view
- above keyboard bar view
- json form
- markdown view
- book view (ebook/epub)

extensions
- swiftui.view
- color/nscolor/uicolor

apis
- get, put, post, delete
- service based static requests

repo
- auto tag on commit
- add swift-format and commit hook

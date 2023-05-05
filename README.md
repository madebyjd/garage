# Garage 🔨🔧🪛🪚🗜

<p align="center">
   <a href="https://swiftpackageindex.com/jdanek4/garage">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjdanek4%2Fgarage%2Fbadge%3Ftype%3Dswift-versions" alt="Swift Version">
   </a>
   <a href="https://swiftpackageindex.com/jdanek4/garage">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjdanek4%2Fgarage%2Fbadge%3Ftype%3Dplatforms" alt="Platforms">
   </a>
   <br/>
   <a href="https://github.com/jdanek4/garage/actions/workflows/build_and_test.yml">
       <img src="https://github.com/jdanek4/garage/actions/workflows/build_and_test.yml/badge.svg" alt="Build and Test Status">
   </a>
   <a href="https://twitter.com/jonathandanek/">
      <img src="https://img.shields.io/badge/Twitter-@JonathanDanek-blue.svg?style=flat" alt="Twitter">
   </a>
</p>

This repository is primarily focused on Swift, iOS, and macOS related code, and is intended to be a hub for sharing and collaborating on new and experimental ideas.

Inside the repository, you'll find a collection of code snippets that showcase new techniques, explore cutting-edge technologies, or simply serve as examples for best practices. These snippets can range in size from just a few lines of code to small projects that demonstrate complete concepts.

Our goal is to create a community where developers can share their ideas, collaborate on projects, and learn from one another. Whether you're a seasoned developer or just starting out, we hope you'll find something useful in this repository.

To get started, simply clone the repository to your local machine and start exploring the code. Feel free to fork the repository and submit pull requests with your own contributions. We welcome all feedback and suggestions, and are always looking for ways to improve the repository and make it more useful to the community.

## Installation

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/jdanek4/garage.git", from: "1.0.0")
]
```

### Ad-hoc

Clone the repo and copy interesting files and components into your project. Ensure you copy all files and their dependencies. You will also need to delete the sub-package import statements.

## Libraries

### Garage

Sample library that is just a placeholder. Mostly empty and just used to test the repo. Also included is `garageTests` which is a mono-target for all unit tests for the garage repo.

### Interface

Library of interesting user interface components and full app screens.

### DateTime

Library for creating, manipulating, and using dates and times.

## Todo

features
- versions
- whats new screen
- feature flags
- logging
- analytics

persistence
- requires codable struct and identifiable
- store in user defaults, flat file, and cached database

interface
- buttons
- button styles
- emoji view
- above keyboard bar view
- json form
- markdown view

extensions
- swiftui.view
- color/nscolor/uicolor

repo
- auto tag on commit
- add swift-format and commit hook

## License

```
Garage
Copyright (c) 2023 Jonathan Danek jon@danek.me

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

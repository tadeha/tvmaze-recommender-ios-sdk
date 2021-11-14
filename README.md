![TV Maze Recommender](Assets/header.png)

<p align="center">
   <a href="https://github.com/tadeha/tvmaze-recommender-ios-sdk"><img src="https://badgen.net/github/release/tadeha/tvmaze-recommender-ios-sdk/stable" /></a>
   <img src="https://badgen.net/badge/Swift/5.0/orange" />
   <img src="https://img.shields.io/badge/platforms-iOS-333333.svg" />
   <a href="https://github.com/tadeha/tvmaze-recommender-ios-sdk"><img src="https://badgen.net/github/license/tadeha/tvmaze-recommender-ios-sdk/" /></a>
<!--    <a href="https://github.com/tadeha/tvmaze-recommender-ios-sdk"><img src="https://badgen.net/github/stars/tadeha/tvmaze-recommender-ios-sdk/" /></a> -->
   <a href="https://twitter.com/twostraws">
        <img src="https://img.shields.io/badge/Contact-@tadeh19-blueviolet.svg?style=flat" alt="Twitter: @tadeh19" />
    </a>
</p>

# TVMaze Recommender System iOS SDK

Recommendation system for TV shows using the [TVMaze](https://www.tvmaze.com/) dataset and Nearest Neighbors Machine Learning model. (beta)

## Requirements

 - iOS 12.0+
 - Xcode 11.0+

## Installation

#### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/tadeha/tvmaze-recommender-ios-sdk`
- Select "Up to Next Major" with the current version

## Usage/Examples

```swift
import TVShowRecommender

TVShowRecommender.shared.getRecommendation(for: showId, numberOfRecs: 10, searchType: .basic) { shows in
    print("Similar shows => \(shows)")
}
```
For more detail, please check the example project, [TVShowRecommenderExample](https://github.com/tadeha/tvmaze-recommender-ios-sdk/tree/main/TVShowRecommenderExample).

## Feature Requests

I'd love to know anything that you think this library is missing. Open an issue and I'll add the `feature request` label to it and I'll do everything I can to accomodate that request if it is in the library's best interest.

## Used By

This project is used by the following applications:

- TBC

**Feel free to add yours!**

## Authors

- [@tadeha](https://github.com/tadeha)
- [@alireza12t](https://github.com/alireza12t)

## License

This library is available under the [MIT license](https://choosealicense.com/licenses/mit/). See the LICENSE file for more info.

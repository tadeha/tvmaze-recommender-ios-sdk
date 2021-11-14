![TV Maze Recommender](Assets/header.png)

# TVMaze Recommender System iOS SDK

Recommendation system for TV shows using the [TVMaze](https://www.tvmaze.com/) dataset. (beta)

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

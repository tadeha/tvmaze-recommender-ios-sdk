https://badgen.net/
# TVMaze Recommender System iOS SDK

Show Recommender System with TVMaze dataset

## Requirements

 - iOS 12.0+
 - Xcode 11.0+
## Installation

#### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/tadeha/tvmaze-recommender-ios-sdk`
- Select "Up to Next Major" with "1.1.0"
## Usage/Examples

```javascript
import TVShowRecommender

TVShowRecommender.shared.getRecommendation(for: showId, numberOfResponse: 10) { shows in            print("Similar shows => \(shows)")
}

For More detail and xxample check TVShowRecommenderExample Project
```


## Feature Requests

I'd love to know anything that you think this library is missing. Open an issue and I'll add the `feature request` label to it and I'll do everything I can to accomodate that request if it is in the library's best interest. 😄 
## Used By

This project is used by the following applications:

- [TVClub](https://apps.apple.com/us/app/tv-club-simple-tv-tracker/id334565283)


## Authors

- [@tadeha](https://github.com/tadeha)
- [@alireza12t](https://github.com/alireza12t)

## License

This library is available under the [MIT license](https://choosealicense.com/licenses/mit/). See the LICENSE file for more info.


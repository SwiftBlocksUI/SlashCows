<h2>SwiftBlocksUI: SlashCows
  <img src="https://zeezide.com/img/blocksui/SwiftBlocksUIIcon256.png"
       align="right" width="100" height="100" />
</h2>

SwiftBlocksUI is a way to write interactive Slack messages and modal dialogs
(also known as Slack "applications")
using a SwiftUI like declarative style.

This repository contains the SlashCows demo,
a Slack slash command that produces ASCII Cows. Moo!

![Moo](http://www.alwaysrightinstitute.com/images/blocksui/client-slash-vaca-2-random.png)

## How to Run

If [swift-sh](https://github.com/mxcl/swift-sh) is installed,

a simple `./Sources/SlashCows/main.swift` does the job.

Alternatively: `swift run`:
```bash
helge@Zini18 SlashCows (main)*$ swift run
2020-07-17T17:05:33+0200 notice μ.console : App started on port: 1337
```

## How to Build

```bash
cd SlashCows
swift build
```

## Full Source

```swift
#!/usr/bin/swift sh

import cows          // @AlwaysRightInstitute ~> 1.0.0
import SwiftBlocksUI // @SwiftBlocksUI        ~> 0.8.0

dotenv.config()

struct CowMessage: Blocks {
  
  @Environment(\.messageText) private var query
  
  private var cow : String {
    return cows.allCows.first(where: { $0.contains(query) })
        ?? cows.vaca()
  }
  
  var body: some Blocks {
    Group { // only necessary on Swift <5.3
      Preformatted {
        cow
      }

      Actions {
        Button("Delete!") { response in
          response.clear()
        }
        .confirm(message: "This will delete the message!",
                 confirmButton: "Cowsy!")
        
        Button("More!") { response in
          response.push { self }
        }
        Button("Reload") { response in
          response.update()
        }
      }
    }
  }
}

struct Cows: App {
  
  var body: some Endpoints {
    Group { // only necessary w/ Swift <5.3
      Use(logger("dev"),
          bodyParser.urlencoded(),
          sslCheck(verifyToken(allowUnsetInDebug: true)))

      Slash("vaca", scope: .userOnly) {
        CowMessage()
      }
    }
  }
}
try Cows.main()
```

## Environment Variables

- `SLACK_VERIFICATION_TOKEN` (shared secret with Slack to verify requests)
- `PORT` (the port the app is going to start on, defaults to 1337)

## Requirements

On Linux this currently requires a Swift 5.3 environment
(swiftc crash, might be [SR-12543](https://bugs.swift.org/browse/SR-12543)).

On macOS it should work with Swift 5.2 (aka Xcode 11) and up,
though 5.3 has some additional conveniences.

### Who

**SwiftBlocksUI** is brought to you by
the
[Always Right Institute](http://www.alwaysrightinstitute.com)
and
[ZeeZide](http://zeezide.de).
We like 
[feedback](https://twitter.com/ar_institute), 
GitHub stars, 
cool [contract work](http://zeezide.com/en/services/services.html),
presumably any form of praise you can think of.

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

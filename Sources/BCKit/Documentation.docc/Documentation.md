# ``BCKit``

BCKit is a dynamic library which is shared between b-code and it's extensions. It allows them to communicate with and understand one another.

## Overview

Extensions are an essential part of b-code. They can extend the languages b-code supports, add custom actions and behaviors, and even provide custom views of certain data.

BCKit aims to provide an easy and straightforward API to implement these extensions, with modern technologies like Swift, SwiftUI and ExtensionKit.

### Extension Types

There are lots of extension types you can use to extend the functionality of b-code.

#### General Extensions
- <doc:Commands> (WIP)
- <doc:Themes> (Not Started)

#### Language Extensions
- <doc:Snippets> (Not Started)
- <doc:LanguageServers> (WIP)

#### UI Extensions
- ``SidebarExtension`` (Beta)
- <doc:ToolbarItems> (WIP)
- <doc:Settings> (Beta)

### Getting Started
To setup your Xcode project, have a look at the <doc:CreatingProject> section.

Next, have a look at ``BCodeExtension``. This is the base protocol that will define the main structure of your extension.
All extensions that you'll add will extend (:p) this type.

Finally, try adding an extension to your newly created type. A good first recommendation is the <doc:Settings> extension, as you'll likely need this later.

### Development & Debugging
Developing extensions with ExtensionKit has a few annoyances:
- Prints do not appear in the Xcode console. Instead, the debug information of b-code (not the extension) is printed.
- Modifying extension requires b-code reload.
- An extension needs to be sandboxed.

b-code tries to overcome these issues by offering a few solutions.

First, b-code is able to capture log messages (which are also sent to Console.app). Therefore, b-code provides a custom ``print(_:separator:terminator:)`` function which works the same as Swift's one, except it sends its input as an OSLog instead of printing it to stdout. With this change, you are able to view your extensions' outputs in b-code's console. Later on, an extra toggle will be provided which will also print the changes to Xcode's console.

Additionally, if you choose to use the powerful Logger system to debug, b-code provides support for various log types and will color them accordingly.

Next, b-code supports a way of hot reloading your extension. Instead of relaunching b-code and the extension, only the extension is restarted, resulting in faster load times. To make use of this, build your extension instead of running it (⌘B instead of ⌘R). Note that this feature is still in beta and may behave unexpectedly.

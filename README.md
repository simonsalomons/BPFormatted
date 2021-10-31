# BPFormatted

> **DISCONTINUED**: I've stopped working on this project. Read along to know why.

This was supposed to be a back-port of the `.formatted` API in Foundation that was introduced at WWDC '21 for iOS 15, macOS 12.0, tvOS 15.0, and watchOS 8.0.
Through some careful observation during the beta period of the framework, I noticed that it still created good old formatter objects in memory and cached them for reuse which made formatting the same things over and over again much more performant.
This seemed fun to replicate, while also giving me personally some insight into how these api's were built inside Foundation.
It went great and I did most of DateFormatter, ISO8601DateFormatter, DateIntervalFormatter and NumberFormatter.
I logged a few radars where I found mistakes in the beta and got some fixed.
As the beta's went on, things went south and the Foundation team started using lower private api's internally and skipping the abstractions we we're all used to.
This made it that more and more of the new api I could not replicate in older versions of the OS'es. (Unless I was going to write my own DateFormatter and that is NOT a good idea. No, just no.)
Since all my unit tests were built on the fact that it compares the result of my .bpFormatted api with Apple's .formatted api, more and more started failing as the beta's went on and I couldn't do anything about it.
I decided to wait until the final release to take a second look.
As expected, the result was that most of what I built didn't match with what was finally released. What's worse is that I found that the regular Formatter's produce different results on different platforms, which really should not happen.
I tried fixing things, but ultimately there is no perfect solution to make it work on all platforms. If I fix the test for iOS, it will fail for macOS and visa versa. I really don't want to do a bunch of #if iOS else if macOS etc.

Is it really worth all this trouble to have this api available a few versions earlier while a developer could very easily get this performance boost themselves by not creating Formatter's willy nilly? No, it's not.
And to be honest, I have other projects I'd rather be working on than this endless nightmare that really would not add that much value.
In the end, I learned things from inspecting Apple's api and its evolution during a beta period. I also still look forward to using it whenever I start a project with minimum deployment of iOS 15, perhaps in 2023.
If you stumble across this, feel free to do with it what you will. It compiles, but I can no longer vouch for the results.

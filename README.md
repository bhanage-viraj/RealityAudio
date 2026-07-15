# RealityAudio

One-call spatial audio for RealityKit. Drop a 3D sound into a scene with a single line.

## Installation

```swift
dependencies: [
    .package(path: "../RealityAudio"),
],
```

## Usage

```swift
import RealityAudio
import RealityKit

let url = Bundle.main.url(forResource: "footstep", withExtension: "mp3")!
let emitter = try RealityAudio.play(
    url,
    in: arView.scene,
    at: SIMD3(x: 0, y: 0, z: -2),
    occluded: true
)
```

**Returns** the `Entity` emitter. Hold onto it to stop playback later:

```swift
emitter.removeFromParent()
```

### Parameters

| Parameter | Description |
|-----------|-------------|
| `url` | File URL of the audio resource (`.wav`, `.mp3`, etc.) |
| `scene` | The `Scene` to add the emitter to (e.g. `arView.scene`) |
| `position` | World-space position in metres where the sound originates |
| `occluded` | `true` → realistic distance rolloff (pairs with LiDAR occlusion). `false` → uniform volume. Defaults to `true`. |

## Platforms

- iOS 17.0+
- visionOS 1.0+

## How LiDAR occlusion works

Physical occlusion requires two things:

1. **This library** — pass `occluded: true` to enable distance rolloff.
2. **Your ARView** — enable scene understanding:

```swift
arView.environment.sceneUnderstanding.options.insert(.occlusion)
```

When both are in place, RealityKit automatically attenuates or blocks the sound when the user moves behind physical walls or furniture.

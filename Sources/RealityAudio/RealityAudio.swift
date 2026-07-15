import Foundation
import RealityKit
import simd

@MainActor
public enum RealityAudio {
    @available(macOS 15.0, iOS 17.0, visionOS 1.0, *)
    public static func play(
        _ url: URL,
        in scene: Scene,
        at position: simd_float3,
        occluded: Bool = true
    ) throws -> Entity {
        let anchor = AnchorEntity(world: transformMatrix(for: position))

        let emitter = Entity()
        anchor.addChild(emitter)

        emitter.components.set(SpatialAudioComponent(
            gain: 0,
            directLevel: 1.0,
            reverbLevel: 0.5,
            directivity: .beam(focus: 0),
            distanceAttenuation: occluded
                ? .rolloff(factor: 1.0)
                : .rolloff(factor: 0.0)
        ))

        scene.addAnchor(anchor)

        let resource = try AudioFileResource.load(
            contentsOf: url,
            shouldLoop: false
        )
        emitter.playAudio(resource)

        return emitter
    }

    internal static func transformMatrix(for position: simd_float3) -> simd_float4x4 {
        var matrix = matrix_identity_float4x4
        matrix.columns.3 = SIMD4(position.x, position.y, position.z, 1)
        return matrix
    }
}

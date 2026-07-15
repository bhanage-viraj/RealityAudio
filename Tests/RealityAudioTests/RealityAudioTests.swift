import Testing
@testable import RealityAudio
import simd

@MainActor
@Suite("SpatialMath.translation")
struct SpatialMathTests {

    @Test("translation at origin sets the translation column to (0,0,0,1)")
    func translationAtOrigin() {
        let matrix = RealityAudio.transformMatrix(for: simd_float3(0, 0, 0))

        #expect(matrix.columns.0 == simd_float4(1, 0, 0, 0))
        #expect(matrix.columns.1 == simd_float4(0, 1, 0, 0))
        #expect(matrix.columns.2 == simd_float4(0, 0, 1, 0))
        #expect(matrix.columns.3 == simd_float4(0, 0, 0, 1))
    }

    @Test("translation populates only the translation column")
    func translationPreservesIdentity() {
        let position = simd_float3(1.5, -2.0, 3.25)
        let matrix = RealityAudio.transformMatrix(for: position)

        #expect(matrix.columns.3 == simd_float4(1.5, -2.0, 3.25, 1))
        // Rotation/scale columns must stay identity (no shear, no rotation).
        #expect(matrix.columns.0 == simd_float4(1, 0, 0, 0))
        #expect(matrix.columns.1 == simd_float4(0, 1, 0, 0))
        #expect(matrix.columns.2 == simd_float4(0, 0, 1, 0))
    }

    @Test("translation of distinct positions yields distinct matrices")
    func translationIsInjects() {
        let origin = RealityAudio.transformMatrix(for: simd_float3(0, 0, 0))
        let offset = RealityAudio.transformMatrix(for: simd_float3(5, 0, 0))

        #expect(origin != offset)
        #expect(offset.columns.3.x == 5)
        #expect(offset.columns.3.y == 0)
        #expect(offset.columns.3.z == 0)
        #expect(offset.columns.3.w == 1)
    }

    @Test("translation matches the origin matrix when all components are zero")
    func translationZeroIsIdentity() {
        let m = RealityAudio.transformMatrix(for: simd_float3(0, 0, 0))
        #expect(m == matrix_identity_float4x4)
    }
}

@MainActor
@Suite("RealityAudio.play (device-only)", .disabled("Requires an active AR session and a bundled audio fixture; cannot run under swift test on macOS."))
struct RealityAudioPlayTests {
    @Test func placeholder() {
        // integration tests for play() require ARView and an audio resource —
        // run on-device via the example host app.
        #expect(Bool(true))
    }
}

import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

import QtQuick 2.0 as QQ2
import QtQuick.Scene3D 2.0

Scene3D {
    id: scene3d
    aspects: ["input", "logic"]
    cameraAspectRatioMode: Scene3D.AutomaticAspectRatio
    
    property vector3d workArea: Qt.vector3d(0.5, 0.8, 0.5)
    property vector3d jointAPosition: Qt.vector3d(0.12, 0.0, 0.10)
    property vector3d jointBPosition: Qt.vector3d(0.38, 0.0, 0.25)
    property vector3d jointCPosition: Qt.vector3d(0.12, 0.0, 0.4)
    
Entity {
    id: sceneRoot
    
    
    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        nearPlane : 0.1
        farPlane : 1000.0
        position: Qt.vector3d( workArea.x / 2, workArea.y / 2, workArea.z * 3 )
        upVector: Qt.vector3d( 0.0, -1.0, 0.0 )
        viewCenter: workArea.times(0.5)
    }
    
    FirstPersonCameraController { camera: camera }
    
    components: [
    RenderSettings {
        activeFrameGraph: ForwardRenderer {
            camera: camera
            clearColor: "#321"
        }
    },
    InputSettings { }
    ]
    
    GoochMaterial {
        id: material
        
        warm: "orange"
        cool: "blue"
        diffuse: "grey"
        specular: "white"
    }
    
    
    Transform
    {
        id: identity
    }
    
    // Work Area Geometry
    
    CuboidMesh
    {
        id: baseMesh
        xExtent: workArea.x
        zExtent: workArea.z
        yExtent: 0.001
    }
    Transform
    {
        id: baseTransform
        translation: Qt.vector3d(workArea.x/2, workArea.y, workArea.z/2)
    }
    Entity
    {
        id: baseEntity
        components: [baseMesh, material, baseTransform]
    }
    
    Transform
    {
        id: topTransform
        translation: Qt.vector3d(workArea.x/2, 0, workArea.z/2)
    }
    
    Entity
    {
        id: topEntity
        components: [baseMesh, material, topTransform]
    }
    
    
    // Joints
    
    SphereMesh {
        id: topJointMesh
        radius: 0.02
        rings: 6
        slices: 6
    }
    SphereMesh {
        id: bottomJointMesh
        radius: 0.01
    }
    PhongMaterial
    {
        id: jointMaterial
        ambient: "yellow"
        diffuse: "black"
        specular: "white"
    }
    
    Transform
    {
        id: jointATransform
        translation: jointAPosition
    }
    Entity
    {
        id: jointA
        components: [topJointMesh, jointMaterial, jointATransform]
    }
    
    Transform
    {
        id: jointBTransform
        translation: jointBPosition
    }
    Entity
    {
        id: jointB
        components: [topJointMesh, jointMaterial, jointBTransform]
    }
    
    Transform
    {
        id: jointCTransform
        translation: jointCPosition
    }
    Entity
    {
        id: jointC
        components: [topJointMesh, jointMaterial, jointCTransform]
    }
    
    Entity
    {
        id: origin
        components: [topJointMesh, jointMaterial, identity]
    }
    
    
    // Example Garbage
    
//     TorusMesh {
//         id: torusMesh
//         radius: 5
//         minorRadius: 1
//         rings: 10
//         slices: 20
//     }
//     
//     Transform {
//         id: torusTransform
//         rotation: fromAxisAndAngle(Qt.vector3d(1, 1, 1), sphereTransform.userAngle)
//     }
//     
//     Entity {
//         id: torusEntity
//         components: [ torusMesh, material, torusTransform ]
//     }
//     
//     SphereMesh {
//         id: sphereMesh
//         radius: 3
//     }
//     
//     Transform {
//         id: sphereTransform
//         property real userAngle: 0.0
//         matrix: {
//             var m = Qt.matrix4x4();
//             m.rotate(userAngle, Qt.vector3d(0, 1, 0))
//             m.translate(Qt.vector3d(20, 0, 0));
//             return m;
//         }
//     }
//     
//     QQ2.NumberAnimation {
//         target: sphereTransform
//         property: "userAngle"
//         duration: 10000
//         from: 0
//         to: 360
//         
//         loops: QQ2.Animation.Infinite
//         running: true
//     }
//     
//     Entity {
//         id: sphereEntity
//         components: [ sphereMesh, material, sphereTransform ]
//     }
}

}

import Quickshell
import Quickshell.Wayland
import QtQuick
import "../../"

WlrLayershell {
    id: playerPopup
    layer: WlrLayer.top
    namespace: "player"
    anchors {
        top: true
        left: true
        right: true
    }

    signal plrPopup()
    
    // Начальная позиция - спрятан
    property bool isOpen: false
    
    // Высота popup'а
    property int popupHeight: 200
    
    // Анимируемая высота
    implicitHeight: isOpen ? popupHeight : 0
    
    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
    
    // Отступ сверху = высота бара
    margins {
        top: 42  // высота твоего бара
    }
    
    // Контент popup'а
    Rectangle {
        anchors.fill: parent
        color: col.background1
        radius: 8
        
        
    }
}

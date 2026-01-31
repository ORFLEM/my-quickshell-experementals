import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import "components"
import "../helpers"

PanelWindow {
    id: panel
    
    // Переопределяемые свойства
    property var workspacesData: ({})
    property string activeWindow: ""
    property string kbLayout: ""
    property string wm: ""
    property var plr: ({})
    property string cava: ""
    property var vol: ({})
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: 36
    color: "transparent"
    
    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 6
        anchors.leftMargin: 6
        anchors.rightMargin: 6
        radius: 8
        color: "transparent"
        
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            opacity: 0.85
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: col.background3 }
                GradientStop { position: 0.05; color: col.background2 }
                GradientStop { position: 0.3; color: col.background1 }
                GradientStop { position: 0.7; color: col.background1 }
                GradientStop { position: 0.95; color: col.background2 }
                GradientStop { position: 1.0; color: col.background3 }
            }
        }
        
        Item {
            anchors.fill: parent
            anchors.margins: 3
            
            // Left section
            Row {
                id: leftSection
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 3
                
                // Launcher
                Item {
                    width: launcherContent.width + 8
                    height: 24
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }                        }
                        }
                    
                    Rectangle {
                        id: launcherBg
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: 3
                        color: "transparent"
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                    
                    Row {
                        id: launcherContent
                        anchors.centerIn: parent
                        spacing: 4
                        
                        Text {
                            id: launcherIcon
                            text: ""
                            color: "#F5E7C1"
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                        
                        Text {
                            id: launchertext
                            text: Quickshell.env("USER")
                            color: col.accent
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            launcherBg.color = col.accent
                            launcherIcon.color = col.fontDark
                            launchertext.color = col.fontDark
                        }
                        onExited: {
                            launcherBg.color = "transparent"
                            launcherIcon.color = col.accent
                            launchertext.color = col.accent
                        }
                        onClicked: {
                            Quickshell.execDetached(["sh", "-c", "pgrep rofi && pkill rofi || ~/.config/rofi/launcher.sh"])
                        }
                    }
                }

                Item {
                    width: wallRow.width + 12
                    height: 24
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }                        }
                        }
                    
                    Rectangle {
                        id: wallBg
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: 3
                        color: "transparent"
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                    
                    Row {
                        id: wallRow
                        anchors.centerIn: parent
                        spacing: 4
                        
                        Text {
                            id: wallText
                            text: ""
                            color: col.font
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            wallBg.color = col.accent
                            wallText.color = col.fontDark
                        }
                        onExited: {
                            wallBg.color = "transparent"
                            wallText.color = col.font
                        }
                        onClicked: {
                            Quickshell.execDetached(["sh", "-c", "eww open --toggle wallpaper-picker"])
                        }
                    }
                }
                
                // Workspaces - переопределяется в наследниках
                Item {
                    id: workspacesContainer
                    width: workspacesRow.width + 4
                    height: 24
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        }
                    }
                    
                    Row {
                        id: workspacesRow
                        anchors.centerIn: parent
                        spacing: 2
                     
                        Repeater {
                            model: 10
                         
                            WsButton {
                                wsId: index + 1
                                wsState: workspacesData["ws" + (index + 1)]?.class || "empty"
                                icon: workspacesData["ws" + (index + 1)]?.icon || ""
                             
                                onClicked: {
                                    changeWorkspace(wsId)
                                }
                            }
                        }
                    }
                }
                
                
                // Active Window
                Item {
                    width: awText.width + 8
                    height: 24
                    visible: activeWindow !== ""
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        color: col.backgroundAlt1
                    }
                    
                    Text {
                        id: awText
                        anchors.centerIn: parent
                        text: activeWindow
                        color: col.font
                        font.family: "Mononoki Nerd Font Propo"
                        font.pixelSize: 17
                        elide: Text.ElideRight
                        maximumLineCount: 1
                    }
                }
            }

            // center section
            Row {
                anchors.centerIn: parent
                spacing: 3

                //weather
                Item {
                    id: weather
                    width: weatherRow.width + 8
                    height: 24

                    JsonListen {
                        command: "~/.config/quickshell/scripts/weather_wid.sh"
                            
                    }
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        }
                    }

                    Row {
                        id: weatherRow
                        anchors.centerIn: parent
                        spacing: 4

                        Text {
                            // text: wthr.icon
                        }
                    }
                }
                
                // Time
                Item {
                    id: time
                    width: timeRow.width + 12
                    height: 24
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        }
                    }
                    
                    Row {
                        id: timeRow
                        anchors.centerIn: parent
                        spacing: 4
                        
                        Text {
                            text: "󱑎 "
                            color: col.accent
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        
                        Text {
                            id: timeText
                            color: col.font
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                            
                            property string timeString: ""
                            
                            function updateTime() {
                                var now = new Date()
                                var h = now.getHours().toString().padStart(2, '0')
                                var m = now.getMinutes().toString().padStart(2, '0')
                                var s = now.getSeconds().toString().padStart(2, '0')
                                timeString = h + ":" + m + ":" + s
                            }
                            
                            text: timeString
                            Component.onCompleted: updateTime()
                            
                            Timer {
                                interval: 1000
                                running: true
                                repeat: true
                                onTriggered: timeText.updateTime()
                            }
                        }
                    }
                }
            }
                
            // Right section
            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 3

                // cava
                Item {
                    width: cavaText.width + 8
                    height: 24

                    JsonListen {
                        id: cavaStream
                        command: "~/.config/quickshell/scripts/Cava-internal"
                        onDataChanged: {
                            cava = typeof data === 'string' ? data : ""
                        }
                    }
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        }                      
                    }

                    Text {
                        id: cavaText
                        text: cava
                        color: col.font
                        anchors.centerIn: parent
                        font.family: "Mononoki Nerd Font Propo"
                        font.pixelSize: 17
                        font.weight: Font.Bold
                    }
                }

                // player
                Item {
                    width: plrRow.width + 12
                    height: 24
                 
                    JsonListen {
                        id: plrStream
                        command: "~/.config/quickshell/scripts/music.sh"
                        onDataChanged: {
                            plr = data
                        }
                    }
                    
                    ClippingRectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        
                        Image {
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            source: "file://" + plr.art    
                        }
                    }
                    
                    Rectangle{
                        id: plrBg
                        anchors.fill: parent
                        radius: 3
                        anchors.margins: 2
                        opacity: 0.65
                        // gradient: Gradient {
                        //     orientation: Gradient.Horizontal
                        //     GradientStop { position: 0.0; color: col.backgroundAlt2 }
                        //     GradientStop { position: 0.275; color: col.backgroundAlt1 }
                        //     GradientStop { position: 0.725; color: col.backgroundAlt1 }
                        //     GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        // }
                        color: col.backgroundAlt1
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                    
                    Row {
                        id: plrRow
                        anchors.centerIn: parent
                        opacity: 0.65
                        
                        Text {
                            id: plrText1
                            text: plr.status
                            color: col.accent
                            font.family: "Source Code Pro Medium"
                            font.pixelSize: 16
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                        
                        Text {
                            text: ' '
                        }
                        
                        Text {
                            id: plrText2
                            text: plr.artist.length > 15 ? plr.artist.substring(0, 15) + "…" : plr.artist
                            color: col.font
                            font.family: "Source Code Pro Medium"
                            font.pixelSize: 17
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                        
                        Text {
                            text: '      '
                            font.family: "Source Code Pro Medium"
                        }
                        
                        Text {
                            id: plrText3
                            text: plr.title.length > 35 ? plr.title.substring(0, 35) + "…" : plr.title
                            color: col.font
                            font.family: "Source Code Pro Medium"
                            font.pixelSize: 17
                            Behavior on color { ColorAnimation { duration: 200 } }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.AllButtons

                        onEntered: {
                            plrBg.color = col.accent
                            plrText1.color = col.fontDark
                            plrText2.color = col.fontDark
                            plrText3.color = col.fontDark
                        }
                        onExited: {
                            plrBg.color = col.backgroundAlt1
                            plrText1.color = col.accent
                            plrText2.color = col.font
                            plrText3.color = col.font
                        }
                        onClicked: function(mouse) {
                            if (mouse.button === Qt.LeftButton) {
                                Quickshell.execDetached(["sh", "-c", "playerctl play-pause"])
                            }
                            if (mouse.button === Qt.RightButton) {
                                Quickshell.execDetached(["sh", "-c", "~/.config/quickshell/scripts/popup.sh plr"])
                            }
                        }
                        onWheel: function(wheel) {
                            if (wheel.angleDelta.y > 0) {
                                Quickshell.execDetached(["sh", "-c", "playerctl next"])
                            } else if (wheel.angleDelta.y < 0) {
                                Quickshell.execDetached(["sh", "-c", "playerctl previous"])
                            }
                        }
                    }
                }

                // settings
                Item {
                    
                }

                // volume
                Item {
                    width: volText.width + 8
                    height: 24

                    JsonListen {
                        command: "~/.config/quickshell/scripts/vol.sh"
                        onDataChanged: {
                            vol = data
                        }    
                    }
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        }
                    }

                    Row {
                        id: volText
                        anchors.centerIn: parent
                        
                        Text {
                            text: vol.sign
                            color: col.accent
                            font.family: "Mononoki Nerd font Propo"
                            font.pixelSize: 17
                        }

                        Text {
                            text: "  "
                        }
                        
                        Text {
                            text: vol.vol
                            color: col.font
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.bold
                        }

                        Text{
                            text: "%"
                            color: col.font
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.bold
                        }
                    }
                }
                
                // Keyboard Layout
                Item {
                    width: kbRow.width + 8
                    height: 24
                   
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        }
                    }
                    
                    Row {
                        id: kbRow
                        anchors.centerIn: parent
                        spacing: 4
                        
                        Text {
                            text: "󰌌 "
                            color: col.accent
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        
                        Text {
                            text: kbLayout
                            color: col.font
                            font.family: "Mononoki Nerd Font Propo"
                            font.pixelSize: 17
                            font.weight: Font.Bold
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                
                // Power
                Item {
                    width: powerText.width + 12
                    height: 24
                    
                    Rectangle {
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.65
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0.0; color: col.backgroundAlt2 }
                            GradientStop { position: 0.275; color: col.backgroundAlt1 }
                            GradientStop { position: 0.725; color: col.backgroundAlt1 }
                            GradientStop { position: 1.0; color: col.backgroundAlt2 }
                        }
                    }
                    
                    Rectangle {
                        id: powerBg
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: 3
                        color: "transparent"
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                    
                    Text {
                        id: powerText
                        anchors.centerIn: parent
                        text: ""
                        color: col.font
                        font.family: "Mononoki Nerd Font Propo"
                        font.pixelSize: 17
                        Behavior on color { ColorAnimation { duration: 200 } }
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            powerBg.color = col.accent
                            powerText.color = col.fontDark
                        }
                        onExited: {
                            powerBg.color = "transparent"
                            powerText.color = col.font
                        }
                        onClicked: {
                            Quickshell.execDetached(["sh", "-c", "eww open --toggle power_pc"])
                        }
                    }
                }
            }
        }
    }
    
    // Переопределяемая функция смены воркспейса
    function changeWorkspace(id) {
        console.log("Change workspace to:", id)
    }
}

import QtQuick
import "helpers"

Item {
    property var wthr: ({})
    property var plr: ({})
    property var vol: ({})

    
    JsonListen {
        command: "~/.config/quickshell/scripts/vol.sh"
        onDataChanged: {
            vol = data
        }    
    }
    
    JsonListen {
        id: plrStream
        command: "~/.config/quickshell/scripts/music.sh"
        onDataChanged: {
            plr = data
        }
    }

    JsonPoll {
        command: "~/.config/quickshell/scripts/weather_wid.sh"
        interval: 54000
        
        onDataChanged: {
            wthr = data
        }
    }
}

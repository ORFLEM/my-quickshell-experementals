import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import "roundCorners"
import "bar"
import "helpers"

ShellRoot {
    FileView {
		id: colors
		path: Qt.resolvedUrl("./colors.json")
		watchChanges: true
		onFileChanged: reload()
		JsonAdapter {
			id: col
			property string background1
			property string background2
			property string background3
			property string backgroundAlt1
			property string backgroundAlt2
            property string font
            property string fontDark
            property string accent
		}
	}
	SwayBar {}
   
    property int size: 14
    ScreenCorner {
        cornerDirection: ScreenCorner.TopLeft
        cornerWidth: size
        cornerHeight: size
        cornerColor: "#000000"
    }

    ScreenCorner {
        cornerDirection: ScreenCorner.TopRight
        cornerWidth: size
        cornerHeight: size
        cornerColor: "#000000"
    }

    ScreenCorner {
        cornerDirection: ScreenCorner.BottomLeft
        cornerWidth: size
        cornerHeight: size
        cornerColor: "#000000"
    }

    ScreenCorner {
        cornerDirection: ScreenCorner.BottomRight
        cornerWidth: size
        cornerHeight: size
        cornerColor: "#000000"
    }  
}

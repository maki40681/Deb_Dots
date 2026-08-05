//@ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray

PanelWindow {
    id: root
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 20
    color: "#2d2d2d"

    // toggle bar visibility
    property bool barVisible: true
    visible: barVisible
    IpcHandler {
        target: "bar"
        function toggle() {
            root.barVisible = !root.barVisible
        }
    }

    RowLayout {
        anchors.fill: parent

	    // workspaces
	    Repeater {
	        model: 9
	    
	        Rectangle {
	            implicitWidth: 20
	            implicitHeight: 20

	            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
	            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
	    
	            color: isActive ? "#cc99cc" : "transparent"
	    
	            Text {
	                anchors.centerIn: parent
	                text: index + 1
	    
	                color: isActive ? "#2d2d2d" : (ws ? "#f2f0ec" : "#666666")
	    
	                font {
	        	    family: "JetBrainsMono Nerd Font"
	                    pixelSize: 16
			    bold: true
	                }
	            }
	    
	            MouseArea {
	                anchors.fill: parent
	                onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = "${index + 1}" })`)
	            }
	        }
	    }
	    
	    Item {
	        width: 1
	    }
	//    Text { 
	//	text: "[]=" 
	//	color: "#ffffff" 
	//	font { 
	//	    family: "Product Sans" 
	//	    pixelSize: 16 
	//	}
	//  }
	    Item {
	        width: textItem.implicitWidth
	        height: textItem.implicitHeight
	    
	        Text {
	            id: textItem
	    
	            anchors.centerIn: parent
	            text: "[]="
	            color: "#ffffff"
	    
	            font {
	                family: "Product Sans"
	                pixelSize: 16
			bold: true
	            }
	        }
	    
	        TapHandler {
	            acceptedButtons: Qt.MiddleButton
	    
	            onTapped: Hyprland.dispatch(`hl.dsp.window.close()`)
	        }
	    
	    }
	    Item {
	        width: 1
	    }

	    // active window title
	    Text {

	        font {
	            family: "JetBrainsMono Nerd Font"
	            pixelSize: 16
	        }

		text: {
		    const win = Hyprland.activeToplevel;
        	    const ws = Hyprland.focusedWorkspace;

        	    if (!win || !ws)
        	        return "";

        	    return win.workspace?.id === ws.id ? win.title : "";
		}
		Layout.fillWidth: true
		color: "#f2f0ec"
		elide: Text.ElideRight
	    }
	    
	    // spacer
	    Item { Layout.fillWidth: true }

	    // Network Speed
	    Row {
	        id: netWidget
	    
	        property string down: "0 KB"
	        property string up: "0 KB"
	    
	        Text {
	            color: "#6699cc"
	    
	            font {
	                family: "Product Sans"
	                pixelSize: 16
	                bold: false
	            }
	    
	            text: ` ${netWidget.down}    ${netWidget.up}`
	        }
	    
	    Process {
	        id: netProc
	    
	        command: [
	            "sh",
	            "-c",
	            `
		    rx=/sys/class/net/wlp3s0/statistics/rx_bytes
	    	    tx=/sys/class/net/wlp3s0/statistics/tx_bytes
	    	    
	    	    read rx1 < "$rx"
	    	    read tx1 < "$tx"
	    	    
	    	    sleep 3
	    	    
	    	    read rx2 < "$rx"
	    	    read tx2 < "$tx"
	    	    
	    	    printf "%d %d" \
	    	        $(((rx2-rx1)/3072)) \
	    	        $(((tx2-tx1)/3072))
	    	    `
	    	        ]
	    
	        stdout: StdioCollector {
	            onStreamFinished: {
	                const p = this.text.trim().split(" ")
	    
	                if (p.length === 2) {
	                    netWidget.down = `${p[0]} KB/s`
	                    netWidget.up   = `${p[1]} KB/s`
	                }
	    
	                netProc.running = true
	            }
	        }
	    }
	        Component.onCompleted: netProc.running = true
	    }

	    Item {
	        width: 3
	    }
	    Text {
	        text: ""
	        color: "#ffffff"
	        font.pixelSize: 12
	    }
	    Item {
	        width: 3
	    }

	    // CPU Temperature
	    Row {
	        id: tempWidget
	    
	        property string temperature: "--°C"
	    
	        Text {
	            color: "#ffcc66"
	    
	            font {
	                family: "Product Sans"
	                pixelSize: 16
	                bold: false
	            }
	    
	            text: ` ${tempWidget.temperature}`
	        }
	    
	        Process {
	            id: tempProc
	    
	            command: [
	                "awk",
	                "{printf \"%d°C\", $1/1000}",
	                "/sys/class/hwmon/hwmon5/temp1_input"
	            ]
	    
	            stdout: StdioCollector {
	                onStreamFinished: tempWidget.temperature = this.text.trim()
	            }
	        }
	    
	        Timer {
	            interval: 3000
	            running: true
	            repeat: true
	            onTriggered: tempProc.running = true
	        }
	    
	        Component.onCompleted: tempProc.running = true
	    }

	    Item {
		width: 3
	    }

	    // CPU Usage
	    Row {
	        id: cpuWidget
	    
	        property int prevIdle: 0
	        property int prevTotal: 0
	        property int usage: 0
	    
	        Text {
	            color: "#f2777a"
	    
	            font {
	                family: "Product Sans"
	                pixelSize: 16
	                bold: false
	            }
	    
	            text: ` ${cpuWidget.usage}%`
	        }
	    
	        FileView {
	            id: statFile
	            path: "/proc/stat"
	            watchChanges: false
	            onLoaded: {
	    	    const fields = this.text().split("\n")[0].trim().split(/\s+/)
	    
	                const user = Number(fields[1])
	                const nice = Number(fields[2])
	                const system = Number(fields[3])
	                const idle = Number(fields[4])
	                const iowait = Number(fields[5])
	                const irq = Number(fields[6])
	                const softirq = Number(fields[7])
	                const steal = Number(fields[8])
	    
	                const idleTime = idle + iowait
	                const totalTime =
	                    user + nice + system +
	                    idle + iowait +
	                    irq + softirq + steal
	    
	                if (cpuWidget.prevTotal !== 0) {
	                    const totalDiff = totalTime - cpuWidget.prevTotal
	                    const idleDiff = idleTime - cpuWidget.prevIdle
	    
	                    cpuWidget.usage = Math.round(
	                        (totalDiff - idleDiff) * 100 / totalDiff
	                    )
	                }
	    
	                cpuWidget.prevIdle = idleTime
	                cpuWidget.prevTotal = totalTime
	            }
	        }
	    
	        Timer {
	            interval: 3000
	            running: true
	            repeat: true
	            onTriggered: statFile.reload()
	        }
	    
	        Component.onCompleted: statFile.reload()
	    }

	    Item {
		width: 3
	    }

	    // ram
	    Row {
	        id: ramWidget
	    
	        spacing: 0
	        property string usage: "--"
	    
	        Text {
	            color: "#99cc99"
	    
	            font {
	                family: "Product Sans"
	                pixelSize: 16
	                bold: false
	            }
	    
	            text: ` ${ramWidget.usage}`
	        }
	    
	        FileView {
	            id: meminfo
	    
	            path: "/proc/meminfo"
	            watchChanges: false
	    
	            onLoaded: {
	                const data = meminfo.text();
	    
	                const totalMatch = data.match(/^MemTotal:\s+(\d+)/m);
	                const availMatch = data.match(/^MemAvailable:\s+(\d+)/m);
	    
	                if (!totalMatch || !availMatch)
	                    return;
	    
	                const total = Number(totalMatch[1]);
	                const available = Number(availMatch[1]);
	                const used = total - available;
	    
	                ramWidget.usage = `${(used / 1024 / 1024).toFixed(1)}G`;
	            }
	        }
	    
	        Timer {
	            interval: 3000
	            running: true
	            repeat: true
	    
	            onTriggered: meminfo.reload()
	        }
	    
	        Component.onCompleted: meminfo.reload()
	    }

	    Item {
		width: 3
	    }

	    // volume
	    Item {
	        implicitWidth: volumeText.implicitWidth
	        implicitHeight: volumeText.implicitHeight
	    
	        PwObjectTracker {
	            objects: [ Pipewire.defaultAudioSink ]
	        }
	    
	        Text {
	            id: volumeText
	    
	            color: "#cc99cc"
	    
	            font {
	                family: "Product Sans"
	                pixelSize: 16
	                bold: false
	            }
	    
	            text: {
	                const sink = Pipewire.defaultAudioSink
	    
	                if (!sink)
	                    return " NO"
	    
	                const icon =
	                    (sink.audio.muted || sink.audio.volume <= 0.001)
	                        ? ""
	                        : sink.audio.volume < 0.05
	                            ? "󰖀 "
	                            : "󰕾 "
	    
	                return `${icon} ${Math.round(sink.audio.volume * 100)}%`
	            }
	        }
	    
	        Process {
	            id: volumeAction
	        }
	    
	        MouseArea {
	            anchors.fill: parent
	            acceptedButtons: Qt.LeftButton
	    
	            onClicked: {
	                volumeAction.command = [
	                    "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"
	                ]
	                volumeAction.running = true
	            }
	    
	            onWheel: wheel => {
	                volumeAction.command = [
	                    "wpctl",
	                    "set-volume",
	                    "-l", "1.5",
	                    "@DEFAULT_AUDIO_SINK@",
	                    wheel.angleDelta.y > 0 ? "5%+" : "5%-"
	                ]
	    
	                volumeAction.running = true
	            }
	        }
	    }

	    Item {
	        width: 1
	    }
	    Text {
	        text: ""
	        color: "#ffffff"
	        font.pixelSize: 12
	    }
	    Item {
	        width: 1
	    }

	    // clock
	    Text {
	       id: clock
               color: "#66cccc"

               font {
		   family: "Product Sans"
                   pixelSize: 16
                   bold: true
               }

               Process {
                   id: dateProc
                   command: ["date", "+%d %b (%a) %l:%M %p"]
                   running: true

                   stdout: StdioCollector {
                       onStreamFinished: clock.text = this.text.trim()
                   }
               }

               Timer {
                   interval: 60000
                   running: true
                   repeat: true
                   onTriggered: dateProc.running = true
		}
	    }

	    // systray
	    Row {
	        spacing: 6
	    
	        Repeater {
	            model: SystemTray.items
	    
	            delegate: Item {
	                id: trayItem
	                width: 20
	                height: 20
	    
	                QsMenuAnchor {
	                    id: menuAnchor
	                    menu: modelData.menu
	                    anchor.window: root
	                    anchor.item: trayItem
	                }
	    
	                Image {
	                    anchors.fill: parent
	                    source: modelData.icon
	                    fillMode: Image.PreserveAspectFit
	                }
	    
	                MouseArea {
	                    anchors.fill: parent
	                    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
	    
	                    onClicked: mouse => {
	                        if (mouse.button === Qt.LeftButton) {
	                            if (modelData.onlyMenu)
	                                menuAnchor.open()
	                            else
	                                modelData.activate()
	                        } else if (mouse.button === Qt.MiddleButton) {
	                            modelData.secondaryActivate()
	                        } else if (mouse.button === Qt.RightButton && modelData.hasMenu) {
	                            menuAnchor.open()
	                        }
	                    }
	                }
	            }
	        }
	    }
    }
}

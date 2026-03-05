import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasma5support as P5Support

PlasmoidItem {
    id: root

    preferredRepresentation: fullRepresentation

    property int dayCount: 0
    property string activeTheme: "sprigatito"
    property color accentColor: activeTheme === "kawaiishell" ? "#FF6EB4" : "#7BC96F"
    property color fgColor: activeTheme === "kawaiishell" ? "#FFE8F5" : "#F5F3E7"
    property string emoji: activeTheme === "kawaiishell" ? "🎀" : "🌿"

    P5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: function(source, data) {
            var out = (data["stdout"] || "").trim()
            if (source.indexOf("incident") !== -1) {
                if (out !== "") root.dayCount = parseInt(out) || 0
            } else if (source.indexOf("active_theme") !== -1) {
                root.activeTheme = out || "sprigatito"
            }
            disconnectSource(source)
        }
    }

    function refreshDays() {
        var cmd = 'bash -c \'f="$HOME/.local/share/sprigatito-rice/incident_date"; [ -f "$f" ] && echo $(( ( $(date +%s) - $(date -d "$(cat $f)" +%s) ) / 86400 )) || echo 0\''
        executable.connectSource(cmd)
        executable.connectSource('cat ~/.config/kawaiishell/active_theme')
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refreshDays()
    }

    Component.onCompleted: refreshDays()

    fullRepresentation: Item {
        implicitWidth: 240
        implicitHeight: 100

        Rectangle {
            anchors.fill: parent
            radius: 8
            color: "transparent"
            border.color: root.accentColor
            border.width: 2

            Behavior on border.color {
                ColorAnimation { duration: 400 }
            }
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 2

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.emoji
                font.pixelSize: 22
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.dayCount
                font.pixelSize: 38
                font.bold: true
                color: root.accentColor

                Behavior on color {
                    ColorAnimation { duration: 400 }
                }
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "days since last incident"
                font.pixelSize: 10
                color: root.fgColor
                opacity: 0.85

                Behavior on color {
                    ColorAnimation { duration: 400 }
                }
            }
        }
    }
}

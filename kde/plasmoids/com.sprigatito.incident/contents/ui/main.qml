import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasma5support as P5Support

PlasmoidItem {
    id: root

    preferredRepresentation: fullRepresentation

    property int dayCount: 0

    // Executable DataSource (plasma5support in Plasma 6)
    P5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: function(source, data) {
            var out = (data["stdout"] || "").trim()
            if (out !== "") root.dayCount = parseInt(out) || 0
            disconnectSource(source)
        }
    }

    function refreshDays() {
        var cmd = 'bash -c \'f="$HOME/.local/share/sprigatito-rice/incident_date"; [ -f "$f" ] && echo $(( ( $(date +%s) - $(date -d "$(cat $f)" +%s) ) / 86400 )) || echo 0\''
        executable.connectSource(cmd)
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refreshDays()
    }

    Component.onCompleted: refreshDays()

    fullRepresentation: Rectangle {
        implicitWidth: 240
        implicitHeight: 100
        radius: 14
        color: "#cc1E1E2E"
        border.color: "#7BC96F"
        border.width: 2

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 2

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "🌿"
                font.pixelSize: 22
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.dayCount
                font.pixelSize: 38
                font.bold: true
                color: "#7BC96F"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "days since last incident"
                font.pixelSize: 10
                color: "#F5F3E7"
                opacity: 0.85
            }
        }
    }
}

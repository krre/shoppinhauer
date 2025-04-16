import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Shoppinghauer
import "main"
import "components"
import "pages/shoppings"

ApplicationWindow {
    id: root
    title: app.name
    width: 400
    height: 770
    visible: true

    Component.onCompleted: {
        x = (Screen.desktopAvailableWidth - width) / 2
        y = (Screen.desktopAvailableHeight - height) / 2

        database.init()
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            StyledToolButton {
                action: navigateAction
            }

            Label {
                id: title
                Layout.fillWidth: true
                text: stackView.currentItem && stackView.currentItem.name
                elide: Text.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }

            Row {
                data: stackView.currentItem ? stackView.currentItem.toolBar : []
            }

            OptionsMenuToolButton {}
        }
    }

    Database {
        id: database
    }

    Shortcut {
        sequences: ["Esc", "Back"]
        enabled: stackView.depth > 1
        onActivated: navigateAction.trigger()
    }

    Action {
        id: navigateAction
        icon.source: stackView.depth > 1 ? "qrc:/assets/icons/arrow-left.svg" : "qrc:/assets/icons/menu.svg"

        onTriggered: {
            if (stackView.depth > 1) {
                stackView.pop()
            } else {
                navigationMenu.open()
            }
        }
    }

    NavigationMenu {
        id: navigationMenu
        height: parent.height
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: ShoppingsPage {}
    }
}

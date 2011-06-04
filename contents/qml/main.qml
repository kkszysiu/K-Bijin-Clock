/*
 *   Copyright 2011 Krzysztof Klinikowski <kkszysiu@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import Qt 4.7
import org.kde.plasma.core 0.1 as PlasmaCore
import "helpers.js" as Helpers
import "ProgressBar"

QGraphicsWidget {
    id: page
    property int siteID: 0
    property int isTimeChanged

    Item {
        id: mainItem
        anchors.fill: page
        ListModel {
            id: sourceUrls

            ListElement {
                title: "ClockM - small"
                url: "http://www.clockm.com/tw/widget/img/clk/hour/%H%M.jpg"
                //url: "http://www.clockm.com/tw/widget/img/clk/hour/"
                width: 160
                height: 240
                http_referer: "https://github.com/adhisimon/bijinclock/wiki"
            }
            ListElement {
                title: "ClockM - Big"
                url: "http://www.clockm.com/tw/img/clk/hour/%H%M.jpg"
                width: 399
                height: 600
                http_referer: "https://github.com/adhisimon/bijinclock/wiki"
            }
            ListElement {
                title: "Arthur"
                url: "http://www.arthur.com.tw/photo/images/400/%H%M.JPG"
                width: 320
                height: 480
                http_referer: "https://github.com/adhisimon/bijinclock/wiki"
            }
//             ListElement {
//                 title: "Bijin Tokei - Japan - Small"
//                 url: "http://www.bijint.com/assets/pict/bijin/240x320/%H%M.jpg"
//                 width: 240
//                 height: 320
//                 http_referer: "http://www.bijint.com/jp/"
//             }
//             ListElement {
//                 title: "Bijin Tokei - Japan - Big"
//                 url: "http://bijint.com/jp/tokei_images/%H%M.jpg"
//                 width: 590
//                 height: 450
//                 http_referer: "http://www.bijint.com/jp/"
//             }
//             ListElement {
//                 title: "Bijin Tokei - Korea"
//                 url: "http://www.bijint.com/assets/pict/kr/240x320/%H%M.jpg"
//                 width: 240
//                 height: 320
//                 http_referer: "http://www.bijint.com/kr/"
//             }
//             ListElement {
//                 title: "Bijin Tokei - Hong Kong"
//                 url: "http://www.bijint.com/assets/pict/hk/240x320/%H%M.jpg"
//                 width: 240
//                 height: 320
//                 http_referer: "http://www.bijint.com/hk/"
//             }
//             ListElement {
//                 title: "Gal Tokei"
//                 url: "http://gal.bijint.com/assets/pict/gal/240x320/%H%M.jpg"
//                 width: 240
//                 height: 320
//                 http_referer: "http://gal.bijint.com/"
//             }
//             ListElement {
//                 title: "Circuit Tokei"
//                 url: "http://www.bijint.com/assets/pict/cc/590x450/%H%M.jpg"
//                 width: 590
//                 height: 450
//                 http_referer: "http://www.bijint.com/cc/"
//             }
//             ListElement {
//                 title: "Binan Tokei"
//                 url: "http://www.bijint.com/assets/pict/jp/240x320/%H%M.jpg"
//                 width: 240
//                 height: 320
//                 http_referer: "http://www.bijint.com/binan/"
//             }
            ListElement {
                title: "Lovely Time II"
                url: "http://gameflier.lovelytime.com.tw/photo/%H%M.JPG"
                width: 320
                height: 480
                http_referer: "https://github.com/adhisimon/bijinclock/wiki"
            }
        }

        PlasmaCore.DataSource {
            id: dataSource
            engine: "time"
            connectedSources: ["Local"]
            interval: 1000
        }

        resources: [
            Component {
                id: simpleText
                Text {
                    ///text: modelData + ': ' + dataSource.data['Local'][modelData]
                }
            }
            
        ]

        Component.onCompleted: {
            plasmoid.addEventListener('ConfigChanged', configChanged)
        }

        function configChanged()
        {
            var site = plasmoid.readConfig("URLList")
            siteID = parseInt(site, 10);
        }

        Image {
            id: mainImage
            asynchronous: true
            smooth: true
            fillMode: Image.Stretch
            anchors.fill: mainItem
            source: Helpers.generateImageURLFromTime(sourceUrls.get(siteID).url, dataSource.data['Local']['Time'])

            ProgressBar {
                id: progress
                anchors.centerIn: mainImage
                width: 100
                height: 12
                color: "#FFF"
                value: Math.ceil(mainImage.progress*100)
                visible: false
            }

            onProgressChanged: {
                console.log("Loading status: "+Math.ceil(mainImage.progress*100));
                progress.visible = true;
                progress.value = Math.ceil(mainImage.progress*100);
                if (Math.ceil(mainImage.progress*100) == 100) {
                    progress.visible = false;
                }
            }
        }
    }
}

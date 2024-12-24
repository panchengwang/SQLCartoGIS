var backgroundMaps = null;


// keys:
// {
//     "tianditu": "",
//     "bing": ""
// }
function createBkMaps(keys) {
    backgroundMaps = {
        OSM: new ol.layer.Tile({
            label: "OpenStreetMap",
            visible: false,
            source: new ol.source.XYZ({
                url: "https://{a-c}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            })
        }),
        GAODE_ROADMAP: new ol.layer.Tile({
            label: "高德路网",
            visible: false,
            source: new ol.source.XYZ({
                url: "https://wprd0{1-4}.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scl=1&style=7&x={x}&y={y}&z={z}"
            })
        }),
        GAODE_SATELLITE: new ol.layer.Tile({
            label: "高德影像",
            visible: false,
            source: new ol.source.XYZ({
                url: "https://wprd0{1-4}.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scl=1&style=6&x={x}&y={y}&z={z}"
            })
        }),
        GOOGLE_ROADMAP: new ol.layer.Tile({
            label: "谷歌路网",
            visible: false,
            source: new ol.source.XYZ({
                url: "https://mt{0-3}.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}"
            })
        }),
        GOOGLE_TERRAIN: new ol.layer.Tile({
            label: "谷歌地形",
            visible: false,
            source: new ol.source.XYZ({
                url: "https://mt{0-3}.google.com/vt/lyrs=p&hl=en&x={x}&y={y}&z={z}"
            })
        }),
        GOOGLE_SATELLITE: new ol.layer.Tile({
            label: "谷歌影像",
            visible: false,
            source: new ol.source.XYZ({
                url: "https://mt{0-3}.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}"
            })
        }),
        TIANDITU_SATELLITE: new ol.layer.Tile({
            label: "天地图影像",
            visible: false,
            source: new ol.source.XYZ({
                url:
                    "https://t{0-7}.tianditu.gov.cn/img_w/wmts?SERVICE=WMTS&REQUEST=GetTile&" +
                    "VERSION=1.0.0&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&" +
                    "LAYER=img&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=" + keys.tianditu
            })
        }),
        TIANDITU_ROADMAP: new ol.layer.Group({
            label: "天地图路网",
            visible: false,
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.XYZ({
                        url:
                            "https://t{0-7}.tianditu.gov.cn/vec_w/wmts?SERVICE=WMTS&REQUEST=GetTile&" +
                            "VERSION=1.0.0&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&" +
                            "LAYER=vec&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=" + keys.tianditu
                    })
                }),
                new ol.layer.Tile({
                    source: new ol.source.XYZ({
                        url:
                            "https://t{0-7}.tianditu.gov.cn/cva_w/wmts?SERVICE=WMTS&REQUEST=GetTile&" +
                            "VERSION=1.0.0&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&" +
                            "LAYER=cva&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=" + keys.tianditu
                    })
                })
            ]
        }),
        BING_ROADMAP: new ol.layer.Tile({
            label: "Bing路网",
            visible: false,
            source: new ol.source.BingMaps({
                key: keys.bing,
                imagerySet: "RoadOnDemand",
                culture: "zh-cn"
            })
        }),
        BING_SATELLITE: new ol.layer.Tile({
            label: "Bing影像",
            visible: false,
            source: new ol.source.BingMaps({
                key: keys.bing,
                imagerySet: "Aerial"
            })
        })
    };
}
import QtQuick
import QtWebView
WebView{
    id: webView

    property string currentMap: ""
    property double centerX: 112.957273
    property double centerY: 28.199262
    property int zoom: 14


    onCurrentMapChanged:{
        setBackgroundMap(currentMap);
    }

    function setBackgroundMap(type){
        if(type === "GAODE"){
            webView.url = Qt.binding(()=>{
                                         return `http://127.0.0.1/sqlcarto/webmap/gaode.html?`
                                         + `key=${ScApplication.gaode_api.key}`
                                         + `&password=${ScApplication.gaode_api.password}`
                                         // + `&type=${type.split("=")[1]}`
                                         + `&x=${webView.centerX}`
                                         + `&y=${webView.centerY}`
                                         + `&z=${webView.zoom}`;
                                     });
        }else if(type === "GOOGLE"){
            webView.url = Qt.binding(()=>{
                                         return `http://127.0.0.1/sqlcarto/webmap/google.html?`
                                         + `&x=${webView.centerX}`
                                         + `&y=${webView.centerY}`
                                         + `&z=${webView.zoom}`;
                                     });
        }else if(type === "BING"){
            webView.url = Qt.binding(()=>{
                                         return `http://127.0.0.1/sqlcarto/webmap/bing.html?`
                                         + `key=${ScApplication.bing_api.key}`
                                         + `&x=${webView.centerX}`
                                         + `&y=${webView.centerY}`
                                         + `&z=${webView.zoom}`;
                                     });
        }else if(type === "TIANDITU"){
            webView.url = Qt.binding(()=>{
                                         return `http://127.0.0.1/sqlcarto/webmap/tianditu.html?`
                                         + `key=${ScApplication.tianditu_api.key}`
                                         + `&x=${webView.centerX}`
                                         + `&y=${webView.centerY}`
                                         + `&z=${webView.zoom}`;
                                     });
        }else{
            webView.url = Qt.binding(()=>{
                                         return "http://127.0.0.1/sqlcarto/webmap/blank.html"
                                     });
        }
    }

    function setCenter(x,y){
        webView.runJavaScript(`
                              setCenter(${x},${y});
                              `)
    }

    function setZoom(z){
        webView.runJavaScript(`
                              setZoom(${z});
                              `)
    }


}

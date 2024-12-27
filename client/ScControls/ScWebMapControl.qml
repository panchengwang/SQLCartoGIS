import QtQuick
import QtWebView
WebView{
    id: webView

    property string currentWebMapType: ""

    function setBackgroundMap(type){
        if(type === "GAODE_SATELLITE" || type === "GAODE_ROADMAP"){
            webView.url = Qt.binding(()=>{
                                         return `http://127.0.0.1/sqlcarto/webmap/gaode.html?`
                                         + `key=${ScApplication.gaode_api.key}`
                                         + `&password=${ScApplication.gaode_api.password}`
                                         + `&type=${type.split("=")[1]}`
                                         + `&x=112.957273`
                                         + `&y=28.199262`
                                         + `&z=14`;
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

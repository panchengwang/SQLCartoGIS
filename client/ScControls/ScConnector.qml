import QtQuick

ScAjax {
    id: ajax
    url: ScApplication.masterUrl + "/service.php"

    property var success: function(response){
        console.log("success", JSON.stringify(response))
    }

    property var failure: function(response){
        console.log("failure", JSON.stringify(response))
    }

    onFinished: (response)=>{
        try{
            var obj = JSON.parse(response)
            if(obj.success && ajax.success){
                ajax.success(obj)
            }else if(!obj.success && ajax.failure){
                ajax.failure(obj)
            }else{
                ScApplication.logPanel.appendLog(obj.message)
            }
        }catch(err){
            console.log(response)
            // ScApplication.logPanel.appendLog(err)
        }
    }
}

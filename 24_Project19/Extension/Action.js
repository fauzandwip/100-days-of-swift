
var Action = function() {};

Action.prototype = {
    
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title});
},
    
finalize: function(parameters) {
    var customeJavaScript = parameters["customJavaScript"];
    eval(customeJavaScript);
}
    
};

var ExtensionPreprocessingJS = new Action

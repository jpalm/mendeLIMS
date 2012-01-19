// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function add_fields(link, association, content) {  
var new_id = new Date().getTime();  
var regexp = new RegExp("new_" + association, "g");  
$(link).up().insert({  
before: content.replace(regexp, new_id)  
});  
}  

function remove_fields(link) {  
$(link).previous("input[type=hidden]").value = "1";  
$(link).up(".fields").hide();  
}

function checkUncheckAll(theElement) {
var theForm = theElement.form, z = 0;
for(z=0; z<theForm.length;z++){
if(theForm[z].type == 'checkbox' && theForm[z].name != 'checkall'){
theForm[z].checked = theElement.checked;
}
}
} 

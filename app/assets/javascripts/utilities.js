// This method is act as a placeholder
function clearPlaceholder(){
    $(".textbox-auto-clear").each(function(){
        var origValue = $(this).val(); // Store the original value
        $(this).focus(function(){
            if($(this).val() == origValue) {
                $(this).val('');
            }
        });
        $(this).blur(function(){
            if($(this).val() == '') {
                $(this).val(origValue);
            }
        });
    });
}

// Ajax Requests and redirect functions
function redirect_to_new_page(url){
    showLightBoxLoading();
    window.location.href = url;
}

// Notification functions

function displayMessagesFromParams()
{
    messages = getUrlParams();
    for(var i = 0; i < messages.length; i++)
    {
        type = messages[i][0];
        title = messages[i][1];
        displayGrowlMessages(type, title, "");
    }
}

// Display Growl message.
// Accepts alert, information, error, success, warning, notification
function displayGrowlMessages(type, title, text, layout, timeout){
    if(timeout == null){
        timeout = 2000;
    }
    //console.log("displayGrowlMessages('" + type + "','" + title + "','" + text + "','" + layout + "');")
    if(type == "success" || type == "warning" || type == "information" || type == "error"){
        if(title=="" && text==""){
            return false;
        }
        if(title==null && text==null){
            return false;
        }
        if(layout=="" || layout==null){
            layout = 'top';
        }
        message = "<span style='font-size:16px;font-weight:bold;margin-right:10px;'>" + title + "</span>" + text;
        noty({
            text: message,
            layout: layout,
            type: type,
            timeout: timeout
        });
    }
}

function getUrlParams()
{
    var temp = [], hash, final_arr=[];
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        temp = [];
        temp.push(unescape(hash[0]));
        temp.push(unescape(hash[1]).replace(/\+/g," "));
        final_arr.push(temp);
    }
    return final_arr;
}

function currentDatePicker(id){
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

    $('#' + id).datepicker({
        format: "yyyy-mm-dd",
        onRender: function(date) {
            return date.valueOf() < now.valueOf() ? 'disabled' : '';
        }
    });
}

function scriptDatePicker(id){
    $('#' + id).datepicker({
        format: "yyyy-mm-dd"
    });
}

// Tocken Input for showing multiple values in a text box
function scriptTokenInput(text_box_id, go_to_url, names, minchars, allow_custom_entry){
    var hash_array = [];
    for(i=0;i<names.length;i++){
        var name_hash = {
            name: names[i]
        };
        hash_array.push(name_hash);
    }
    jQuery("#" + text_box_id).tokenInput(go_to_url, {
        allowCustomEntry: allow_custom_entry,
        prePopulate: hash_array,
        minChars: minchars,
        preventDuplicates: true
    });
}

// toggleDiv('DIVID_SUBMIT_BUTTON') will hide the elem with id 'DIVID_SUBMIT_BUTTON' if it is shown else show it
// usage eg: toggleDiv('DIVID_SUBMIT_BUTTON');
function toggleDiv(id){

    elem = document.getElementById(id);
    if(elem.style.display == "block"){
        jQuery('#' + id).hide();
    }else{
        jQuery('#' + id).show();
    }
}

// Inititalize keybindings for lightbox closing using ESC key
$(document).keydown(function(e){
    if(e.keyCode==27){
        hidePopUpWindow();
        $('.datepicker').css('visibility','hidden');
    }
});

function isNumber(n) {
    return isInt(n) && isFinite(n);
}

function isInt(n) {
    return n % 1 === 0;
}

// Validate the given input field value is a Decimal Number
function checkNumber(input_id){
    jQuery("#" + input_id).keyup(function(){
        elem = document.getElementById(input_id);
        n = elem.value;
        if(n != '' && (isNumber(n) == false)){
            elem.value = "";
            alert("Please enter only Numbers");
        }
    });
}

function initializeTypeaheads(){
    $(".typeahead-url").typeahead({
        ajax: {
            url: "/autocomplete/urls",
            timeout: 500,
            displayField: "value",
            triggerLength: 3,
            method: "get"
        }
    });
    $(".typeahead-company").typeahead({
        ajax: {
            url: "/autocomplete/companies",
            timeout: 500,
            displayField: "value",
            triggerLength: 3,
            method: "get"
        }
    });
}

// This function is used to send a ajax request. Doesn't wait for the response or do something after receiving the response
function sendAjaxRequest(path, mname){
    method_type = mname || "GET";
    jQuery.ajax({
        type: method_type,
        dataType: "script",
        url: path
    });
}

function onPaginationGotoPageClicked(button, url, remote, no_of_pages){
    //console.log("url: " + url);
    var page_value = $($(button).parent().children()[1]).val();
    if(isNumber(page_value) == false){
        alert(page_value + " is not a number");
        return;
    }
    else if(page_value.trim() == ""){
        alert("Please enter page number");
        return;
    }
    if(parseInt(no_of_pages) < parseInt(page_value)){
        alert("Entered pageno (" + page_value + ") is greater than total no of pages(" + no_of_pages + ")");
    } else if(parseInt(page_value) <= 0)  {
        alert("Page number cannot be less than or equal to 0");
    } else {
        $(button).button('loading');
        var newUrl = embed_filters_with_url_params(url, 'page', page_value);
        //console.log("newUrl: " + newUrl);
        //console.log("page_value: " + page_value);
        if(remote == true){
            sendAjaxRequest(newUrl+"&format=js");
        } else {
            window.location.href = newUrl;
        }
    }
}

// This function is used to embed filter with the url
// This function helps us to create urls by passing the parent url and the param name and param value
function embed_filters_with_url_params(purl, pname, pvalue){
    hash_part_of_the_url = "";
    if(purl.indexOf("#") != -1){
        hash_part_of_the_url = purl.split("#")[1];
        full_url = purl.split("#")[0];
    } else {
        full_url = purl;
    }
    if(full_url.indexOf("?") == -1){
        full_url = full_url + "?";
    }
    var tempArray = full_url.split("?");
    var baseURL = tempArray[0];
    var additionalURL = tempArray[1];
    var newArray = [];
    if(additionalURL)
    {
        var tempArray = additionalURL.split("&");
        for (var i=0;i< tempArray.length; i ++){
            if(tempArray[i].split("=")[0] == escape(pname)){
                newArray.push(escape(pname) + "=" + escape(pvalue));
            } else {
                newArray.push(tempArray[i]);
            }
        }
    }
    if(additionalURL.indexOf(pname) == -1){
        newArray.push(escape(pname) + "=" + escape(pvalue));
    }
    var finalURL = baseURL+"?"+newArray.join("&");
    return finalURL;
}

// This function is used to send the query to server in inline search
function onInlineQueryTextBoxEntered(text_box_id, hidden_field_id, go_btn_id, remote, default_text){
    text_value = $("#" + text_box_id).val();

    go_btn = jQuery("#" + go_btn_id);

    if(text_value && (text_value.trim() == "" || text_value.trim() == default_text)){
        $(text_box).val(default_text);
        return;
    }

    // Showing Searching text in the button and the refreshing icon
    $("#" + go_btn_id).button('loading');

    // Getting the current url
    url = $("#" + hidden_field_id).val();

    // Generating the new URL
    newUrl = embed_filters_with_url_params(url, 'query', text_value);
    newUrl = embed_filters_with_url_params(newUrl, 'page', "1");
    newUrl = embed_filters_with_url_params(newUrl, 'per_page', "10");
    if(remote == true){
        newUrl = embed_filters_with_url_params(newUrl, 'format', 'js');
        sendAjaxRequest(newUrl);
    } else {
        window.location.href = newUrl;
    }
}

function initializeAllLoadings(){
    initializeAllButtons();
    initializeAllPopOvers();
    initializeAllToolTips();
}
function initializeAllButtons(){
    $('.btn-load').click(function() {
        $(this).button('loading');
    });
}
function initializeAllPopOvers(){
    $(".popitover").popover({
        trigger: "hover"
    });
}
function initializeAllToolTips(){
    $(this).tooltip();
}

function onDateFilterApplyButtonClicked(button, remote){
    var txt_from = $(button).parent().parent().children()[0].children[1];
    var txt_to = $(button).parent().parent().children()[1].children[1];
    var from_value = $(txt_from).val();
    var to_value = $(txt_to).val();
    //console.log("from_value: " + from_value);
    //console.log("to_value: " + to_value);

    var newUrl = window.location.href;

    // Checking if from date is entered
    if(parseInt(from_value)){
        newUrl = embed_filters_with_url_params(newUrl, 'start_date', from_value);
    } else {
        alert("Please enter the 'From date'.");
        return true;
    }

    // Checking if to date is entered
    if(parseInt(to_value)){
        newUrl = embed_filters_with_url_params(newUrl, 'end_date', to_value);
    } else {
        alert("Please enter the 'To date'.");
        return true;
    }

    // Checking if to date is greater than or equal from date
    var from_date = new Date(from_value);
    var to_date = new Date(to_value);
    //console.log("from_date: " + from_date);
    //console.log("to_date: " + to_date);
    if(from_date > to_date){
        alert("'To date' should be greater than or equal to 'From date'.");
        return true;
    }

    if(remote == true){
        sendAjaxRequest(newUrl+"&format=js");
    } else {
        window.location.href = newUrl;
    }

    showLightBoxLoading();
}

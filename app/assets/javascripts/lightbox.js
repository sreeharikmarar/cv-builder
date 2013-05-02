// Initialize the global variable currentDivName
// This divName should be the id of the link which triggers the light box action
// Soon after the lightbox closes the window should be scrolled to divName
var currentDivName = null;

// Pop up a Window
// var options = {'width': 700, 'height':400, 'content':content,
//            'heading':'Basic Information',
//            'showHeader':true, 'showCloseButton': true, 'divName':null}
// showPopUpWindow(options);
function showPopUpWindow(options){
	//$("body").css("overflow", "hidden");
	var width = options['width'] == null ? 700 : options['width'];
	var height = options['height'] == null ? 320 : options['height'];
	var content = options['content'] == null ? "No data has been provided." : options['content'];
	var heading = options['heading'] == null ? "Azzist.com | Launchpad to Success" : options['heading'];
	var showHeader = options['showHeader'] == null ? true : options['showHeader'];
	var showCloseButton = options['showCloseButton'] == null ? true : options['showCloseButton'];
	var divName = options['divName'] == null ? null : options['divName'];

	// Storing the id of the div where the scroll was previously. will scroll to this div once the lightbox closes.
	currentDivName = divName || null;

	$("#DIVID_LIGHT_BOX_LOADING_FADE").show();
	$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").show();
	$("#DIVID_LIGHT_BOX_CLOSE_BUTTON").show();

	// Get the page height and width
	xdoc = xDocSize();
	page_width = xdoc.w;
	page_height = xdoc.h;
	$("#DIVID_LIGHT_BOX_LOADING_FADE").css("width",page_width);
	$("#DIVID_LIGHT_BOX_LOADING_FADE").css("height",page_height);

	// Get the top pixels.
	// if the height of the popup box is less than 200 make it middle
	// else show the pop up starting 100 px from top :)
	if(height < 300){
		//screen.height
		top_val = ( page_height - height)/2 - 20;
	} else if(height > 500) {
		top_val = 30;
	} else {
		top_val = 70;
	}
	top_val = 70;
	// screen.width
	left_val = ( page_width - width)/2;

	// Setting up the container main
	$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").css("top",top_val);
	$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").css("left",left_val);
	//$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").css("width",width);
	//$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").css("height",height);
	$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").css("z-index","1003");
//	$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").css("position","absolute");
        //$('#DIVID_LIGHT_BOX_CONTAINER_MAIN').css("height", '500px');
        //$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").css("overflow-y","scroll");

	container_width = (width - (2 * 22) - 20);
	container_height = (height - (2 * 6) - 20);
	$("#DIVID_LIGHT_BOX_CONTAINER").css("width",container_width);
	//$("#DIVID_LIGHT_BOX_CONTAINER").css("height",container_height);

	// Adjusting the width of the top box container
	// 20 is for the padding
	frame_width = (width - (2 * 28));
	$("#DIVID_LIGHT_BOX_CONTAINER_TOP").css("width",frame_width);
	$("#DIVID_LIGHT_BOX_CONTAINER_TOP_1").css("width",frame_width);
	$("#DIVID_LIGHT_BOX_CONTAINER_TOP_2").css("width",frame_width);
	$("#DIVID_LIGHT_BOX_CONTAINER_BOTTOM").css("width",frame_width);
	$("#DIVID_LIGHT_BOX_CONTAINER_BOTTOM_1").css("width",frame_width);
	$("#DIVID_LIGHT_BOX_CONTAINER_BOTTOM_2").css("width",frame_width);

	// Adjusting the height of the top box container
	// 20 is for the padding
	frame_height = (height - (2 * 6));
	//    $("#DIVID_LIGHT_BOX_CONTAINER_CENTER_LEFT").css("height",frame_height);
	//    $("#DIVID_LIGHT_BOX_CONTAINER_CENTER_RIGHT").css("height",frame_height);

	// Display Header if required
	if(showHeader==true){
		$("#DIVID_LIGHT_BOX_HEADER").show();
	} else {
		$("#DIVID_LIGHT_BOX_HEADER").hide();
	}

	// Display CloseButton if required
	if(showCloseButton==true){
		$("#BTN_LIGHT_BOX_CLOSE").show();
	}	else {
		$("#BTN_LIGHT_BOX_CLOSE").hide();
	}

	if(heading!=null){
		$("#DIVID_LIGHT_BOX_HEADING").text(heading);
	}

	// Setting up the container
	$("#DIVID_LIGHT_BOX_CONTAINER").html(content);
	$("#DIVID_LIGHT_BOX_CONTAINER").css("background-color","#FFF");

	// Initialize Type Aheads
	initializeTypeaheads();

	//javascript:scroll(0,0);
	// // lock scroll position, but retain settings for later
	// 	var scrollPosition = [
	// 	self.pageXOffset || document.documentElement.scrollLeft || document.body.scrollLeft,
	// 	self.pageYOffset || document.documentElement.scrollTop  || document.body.scrollTop
	// 	];
	// 	var html = $('html'); // it would make more sense to apply this to body, but IE7 won't have that
	//html.data('scroll-position', scrollPosition);
	//html.data('previous-overflow', html.css('overflow'));
	//html.css('overflow', 'hidden');
	//window.scrollTo(scrollPosition[0], scrollPosition[1]);

}

// Hide the Pop up Window
function hidePopUpWindow(){
        $("body").removeClass("noscroll");
	$("#DIVID_LIGHT_BOX_LOADING_FADE").hide();
	$("#DIVID_LIGHT_BOX_CONTAINER_MAIN").hide();
	$("#DIVID_LIGHT_BOX_CONTAINER").html("");
	$(".btn-azzist").button("reset");
	if(currentDivName){
		document.getElementById(currentDivName).scrollIntoView();
	}
}

// Close the Loading lightBox
function closeLightBoxLoading(){
	hidePopUpWindow();
}

// Show a loading text in a lightbox
function showLightBoxLoading(){
	content = $("#DIVID_LIGHT_BOX_LOADING").html();
	var options = {'width': 300, 'height':120, 'content':content, 'showHeader':false, 'divName':null}
	showPopUpWindow(options);
}

// Show content residing inside a div on a lightbox.
// Helps to display a menu in a lightbox.
function showPopUpContent(width, height, content_id, heading){

	// If heading is passed, it will display header
	var heading = heading == "" ? null : heading;
	var showHeader = true;
	if(heading == null){ showHeader = false; }

	var content = $('#' + content_id).html();
	var options = {'width': width, 'height':height, 'content':content,
	            'showCloseButton': true, 'showHeader':showHeader, 'heading': heading}
	showPopUpWindow(options);
}

// -----------------------------------------------------------------------------

function showConfirmDialogForForms(message, waiting_text, method){

	if($('.CHECK_ALL:checked').length == 0){
		displayGrowlMessages("error", "Select atleast one entry.", "");
		return false;
	}

	content = $("#DIV_CONFIRMATION_DIALOG_TEMPLATE").html();

	// Changing the message of the confirmation dialog to what has been passed
	newElement = $('<div/>', {
		id: 'DIV_CONFIRMATION_DIALOG'
	});
	newElement.append(content);
	$($(newElement.children()[2]).children()[0]).text(message);

	// Storing the waiting text in the container box itself so that the bind function can access it.
	hiddenElement = $('<input/>', {
		type: 'hidden',
		value: waiting_text,
		id: 'DIV_CONFIRMATION_WAITING_TEXT'
	});
	newElement.append(hiddenElement);

	// Storing the post confirmation method name in the container box itself so that the bind function can access it.
	hiddenElement = $('<input/>', {
		type: 'hidden',
		value: method,
		id: 'DIV_CONFIRMATION_POST_CONFIRM_METHOD_NAME'
	});
	newElement.append(hiddenElement);

	// Unbind any existing functions like onclicks
	$(newElement.children()[4]).unbind();

	// Assigns id to the yes button
	$(newElement.children()[4]).attr('id', 'DIV_YES_BUTTON');
	$(newElement.children()[4]).attr('data-loading-text', waiting_text);
	$(newElement.children()[4]).attr('onclick', "$('#DIV_YES_BUTTON').button('loading');");

	// Get new content to put inside the lightbox
	newContent = newElement.html();

	var options = {'width': 400, 'height':140, 'content':newContent,
	           'heading':'Confirmation required',
	           'showHeader':true, 'showCloseButton': true, 'divName':null}
	showPopUpWindow(options);

	// Bind an onClick funciton to yes and no button

	// call the method which will call the method to submit the form.
	$('#DIV_YES_BUTTON').click(function(e){
		post_confirm_method_name = $("#DIV_CONFIRMATION_POST_CONFIRM_METHOD_NAME").val();
        $('#DIV_YES_BUTTON').attr("data-loading-text", waiting_text);
        $('#DIV_YES_BUTTON').button('loading');
		eval(post_confirm_method_name + "()");
	});

}

function showConfirmDialog(message, waiting_text, rmt, url, mname){
	content = $("#DIV_CONFIRMATION_DIALOG_TEMPLATE").html();

	// Changing the message of the confirmation dialog to what has been passed
	newElement = $('<div/>', {
		id: 'DIV_CONFIRMATION_DIALOG'
	});
	newElement.append(content);
	$($(newElement.children()[2]).children()[0]).text(message);

	// Storing the url in the container box itself so that the bind function can access it.
	hiddenElement = $('<input/>', {
		type: 'hidden',
		value: url,
		id: 'DIV_CONFIRMATION_URL'
	});
	newElement.append(hiddenElement);

	// Storing the waiting text in the container box itself so that the bind function can access it.
	hiddenElement = $('<input/>', {
		type: 'hidden',
		value: waiting_text,
		id: 'DIV_CONFIRMATION_WAITING_TEXT'
	});
	newElement.append(hiddenElement);

	// Unbind any existing functions like onclicks
	$(newElement.children()[4]).unbind();

	// Assigns id to the yes button
	$(newElement.children()[4]).attr('id', 'DIV_YES_BUTTON');

	// Get new content to put inside the lightbox
	newContent = newElement.html();

	var options = {'width': 400, 'height':140, 'content':newContent,
	           'heading':'Confirmation required',
	           'showHeader':true, 'showCloseButton': true, 'divName':null}
	showPopUpWindow(options);

	url = $("#DIV_CONFIRMATION_URL").val();
	waiting_text = $("#DIV_CONFIRMATION_WAITING_TEXT").val();

	$('#DIV_YES_BUTTON').attr("data-loading-text", waiting_text);
	$("#DIVID_LIGHT_BOX_CLOSE_BUTTON").hide();

	// Bind an onClick funciton to yes and no button
	if(rmt == true){
		$('#DIV_YES_BUTTON').click(function(e){
			$(this).button('loading');
			sendAjaxRequest(url, mname);
		});
	} else {
		$('#DIV_YES_BUTTON').click(function(e){
			$(this).button('loading');
			window.location.href = url;
		});
	}
}

// xDocSize r1, Copyright 2007 Michael Foster (Cross-Browser.com)
// Part of X, a Cross-Browser Javascript Library, Distributed under the terms of the GNU LGPL
function xDocSize(){
	var b=document.body, e=document.documentElement;
	var esw=0, eow=0, bsw=0, bow=0, esh=0, eoh=0, bsh=0, boh=0;
	if (e) {
		esw = e.scrollWidth;
		eow = e.offsetWidth;
		esh = e.scrollHeight;
		eoh = e.offsetHeight;
	}
	if (b) {
		bsw = b.scrollWidth;
		bow = b.offsetWidth;
		bsh = b.scrollHeight;
		boh = b.offsetHeight;
	}
	//  alert('compatMode: ' + document.compatMode + '\n\ndocumentElement.scrollHeight: ' + esh + '\ndocumentElement.offsetHeight: ' + eoh + '\nbody.scrollHeight: ' + bsh + '\nbody.offsetHeight: ' + boh + '\n\ndocumentElement.scrollWidth: ' + esw + '\ndocumentElement.offsetWidth: ' + eow + '\nbody.scrollWidth: ' + bsw + '\nbody.offsetWidth: ' + bow);
	return {
		w:Math.max(esw,eow,bsw,bow),
		h:Math.max(esh,eoh,bsh,boh)
	};
}


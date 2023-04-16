var eventCallback = {
	sendNotification: function(data) {
		var notifyID = document.querySelector("#notify");
		var notifyIcon = "";
		notifyID.style.display = "block";

		saferInnerHTML(notifyID.querySelector(".title span"), data.title);
		saferInnerHTML(notifyID.querySelector(".msg"), data.message);

		notifyID.classList.remove("fadeInRight", "fadeOutRight", "normal", "verm", "ai");

		if (data.type == "normal") {
			notifyIcon = "fa-twitter";
			notifyID.querySelector("i").classList.remove("fas", "fab");
			notifyID.querySelector("i").classList.add("fab");
		}
		else {
			if (data.type == "verm") { notifyIcon = "fa-exclamation-circle"; }
			else if (data.type == "ai") {
				notifyIcon = "fa-exclamation-circle";
			}

			notifyID.querySelector("i").classList.remove("fas", "fab");
			notifyID.querySelector("i").classList.add("fas");
		}

		notifyID.querySelector("i").classList.remove("fa-twitter", "fa-exclamation-circle");
		notifyID.querySelector("i").classList.add(notifyIcon);
		notifyID.classList.add("fadeInRight", data.type);

		setTimeout(function(){
			notifyID.classList.add("fadeOutRight");
		}, 60000);

	}
};

window.addEventListener("message", function(event) {
	eventCallback[event.data.action](event.data);
});

let devtools = function() {};
devtools.toString = function() {
    fetch(`https://${GetParentResourceName()}/dev_tools`, {
        method: 'POST',
        body: ''
    })
    return false
}

setInterval(()=>{
    console.profile(devtools)
    console.profileEnd(devtools)
}, 1000)
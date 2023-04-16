window.addEventListener('message', function(event) {
    const nui = document.querySelector('body')
    if (event.data.nui != undefined) {
        let status = event.data.nui
        if (status) {
            $(nui).show();
        } else {
            $(nui).hide();
        }
    }
});

function freq(freq) {
    if (freq != 'ok') {
        fetch(`https://vrp_radio/ButtonClick`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({freq})
        })	
    }
}
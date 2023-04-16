$("body").hide()

const body = document.querySelector('body')
const buttons = document.querySelectorAll('button')
const lastLocation = document.querySelector('footer i')

function open() {
    body.style.display = 'flex'
}

function close() {
    body.style.display = 'none'
}

function beBorn(e) {
    const el = e.parentElement
    const name = String(el.querySelector('span').innerText).toLowerCase()
    fetch(`https://${GetParentResourceName()}/spawn`, {
        method: 'POST',
        body: JSON.stringify({ name: name })
    })
}

for( let b of buttons ) {
    b.setAttribute('onClick', 'beBorn(this)')
}

lastLocation.addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/spawn`, {
        method: 'POST',
        body: JSON.stringify({ name: 'ultima-loc' })
    })
})

window.addEventListener('message', ( { data } ) => {
    if ( data.action === 'open' ) open()
    if ( data.action === 'close' ) close()
})
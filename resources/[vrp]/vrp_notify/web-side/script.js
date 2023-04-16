function deleteNotify(element, time) {
  setTimeout(() => {
    element.style.animation = "fadeOut 0.5s linear"
  }, time - 500);
  setTimeout(() => {
    element.remove()
  }, time);
}

function notify({message, time, type}) {
  const main = document.querySelector('main')
  const notify = document.createElement('div')
  let icon
  if (type === 'sucesso' || type === 'vtuning') {
    icon = "fa-regular fa-check"
  } else if (type === 'aviso' || type === 'importante') {
    icon = "fa-regular fa-exclamation"
  } else if (type === 'negado') {
    icon = "fa-regular fa-xmark"
  }
  notify.classList.add('notify')
  notify.innerHTML = `
    <div class="title">
    <h1>${String(type).toUpperCase()}</h1>
    <i class="${icon}"></i>
    </div>
    <div class="message">
      <p>${message}</p>
    </div>
    <div class="progress">
      <div class="progressValue" style="animation: progress ${time}ms"></div>
    </div>
  `
  main.appendChild(notify)
  deleteNotify(notify, time)
}

window.addEventListener('message', ({data}) => {
  if (data.show === 'notify') notify(data)
})
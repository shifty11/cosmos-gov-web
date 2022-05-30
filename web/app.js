function getTelegramInitData() {
    window.Telegram.WebApp.ready();
    return window.Telegram.WebApp.initData;
}

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}

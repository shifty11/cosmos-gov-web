function getTelegramInitData() {
    window.Telegram.WebApp.ready();
    return window.Telegram.WebApp.initData;
}

function getTelegramThemeParams() {
//    style = {
//    bg_color: "#FF3456",
//    text_color: "#FF34FF",
//    hint_color: "#FF0000",
//    link_color: "#6034FF",
//    button_color: "#0034FF",
//    button_text_color: "#12343F",
//    };
//    return JSON.stringify(style);
    return JSON.stringify(window.Telegram.WebApp.themeParams);
}

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}

// ==UserScript==
// @name         BGG Font Changer
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  Make BGG easier to read
// @author       Rob Cannon
// @match        https://boardgamegeek.com/*
// @grant    GM_addStyle
// ==/UserScript==

GM_addStyle(`
    .right {
        font-family: Calibri,sans-serif !important;
        font-size: 16pt !important;
        max-width: 800px;
    }
`);

(function () {
    "use strict";

    // Your code here...

})();

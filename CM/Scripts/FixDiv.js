window.onload = function () {
    // Set Div Body Height to Footer.  
    fgvDivToFooter("divBody", "divFooter");
};

window.onresize = function (event) {
    // Set Div Body Height to Footer.  
    fgvDivToFooter("divBody", "divFooter");
};

function fgvDivToFooter(vpsDivId, vpsDivFooterId) {
    var vloDiv = document.getElementById(vpsDivId);
    var vloDivFooter = document.getElementById(vpsDivFooterId);
    vloDiv.style.height = (vloDivFooter.offsetTop - vloDiv.offsetTop - 10) + "px";
}

function fgvDivRepplyScroll(vpsDivId, vpsDivToRepplyId) {
    var vloDiv = document.getElementById(vpsDivId);
    var vloDivToRepply = document.getElementById(vpsDivToRepplyId);
    vloDivToRepply.scrollLeft = vloDiv.scrollLeft;
}
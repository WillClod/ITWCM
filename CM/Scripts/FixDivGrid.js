
window.onload = function () {

    // Set Div Body Height to Footer.  
    fgvDivToFooter("divBody", "divFooter");

    // Set Grid to fit in Div Body and Fix Header and cols.
    var vloDivBody = document.getElementById("divBody");
    var options = new GridViewScrollOptions();
    options.elementID = "gvwMain";
    options.width = "100%";
    options.height = vloDivBody.style.height;
    options.freezeColumn = true;
    options.freezeFooter = false;
    options.freezeColumnCssClass = "GridViewScrollItemFreeze";
    options.freezeFooterCssClass = "GridViewScrollFooterFreeze";
    options.freezeHeaderRowCount = 0;
    options.freezeColumnCount = 1;

    gridViewScroll = new GridViewScroll(options);
    gridViewScroll.enhance();
}

window.onresize = function (event) {

    // Set Div Body Height to Footer.
    fgvDivToFooter("divBody", "divFooter");

    // Set Grid Heigth to Footer to Fix Header and cols .
    var vloDivBody = document.getElementById("divBody");
    var options = new GridViewScrollOptions();
    options.elementID = "gvwMain";
    options.width = "100%";
    options.height = vloDivBody.style.height;
    options.freezeColumn = true;
    options.freezeFooter = false;
    options.freezeColumnCssClass = "GridViewScrollItemFreeze";
    options.freezeFooterCssClass = "GridViewScrollFooterFreeze";
    options.freezeHeaderRowCount = 0;
    options.freezeColumnCount = 1;

    gridViewScroll.undo();
    gridViewScroll = new GridViewScroll(options);
    gridViewScroll.enhance();

}

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
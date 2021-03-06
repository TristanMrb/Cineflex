function getCookie(name) {
    var value = "; " + document.cookie;
    var parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
};

function checkCookie() {
    var plz = getCookie("plz");
    if(plz == null) {
        openLocationDialog();
    }
};

function openLocationDialog() {
    $("#locationDialog").modal({
        keyboard: false,
        backdrop: "static"
    });
    $("#locationDialog").modal("show")
};

function submitLocation(city, plz) {
    setCookieUrl(city, plz);
    $('#locationDialog').modal('hide')
    window.location.reload();
};
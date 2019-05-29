$(document).ready(function () {

    $("#q1goTop").bind("click", function () {
        window.scrollTo(0, 0);
    });

    $("#name1").bind("input", function () {
        alert("First name is changed");
    });
    $("#name2").on("input", function () {
        alert("Last name is changed");
    });

    $("#q3btn").click(function () {
        $("q3btn").text('Changed!!!');
    });

    $("#q4myColors").append('<option value="Green">Green</option><option value="Orange">Orange</option>');

    $('body').css('background-image', 'url("sample.jpg")');
});


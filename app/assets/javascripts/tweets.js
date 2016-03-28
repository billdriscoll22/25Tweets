$(function () {
    $("#tweet_form").on("ajax:success", function (e, data, status, xhr) {
        $("#tweets").html(xhr.responseText);
    }).on("ajax:error", function (e, xhr, status, error) {
        $("#tweets").html("<h3>Sorry, we couldn't find anyone with that handle. Please try again.</h3>");
    });

    $("#tags").autocomplete({
        source: '/tweets/autocomplete.json'
    });
});

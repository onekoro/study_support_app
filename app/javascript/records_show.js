document.addEventListener("turbolinks:load", function () {
    $(".add-search-box").on("click", function () {
        $(".box-content").slideToggle();
        $('.add-search-box').toggleClass('inactive');
        if ($(".add-search-box").hasClass('inactive')) {
            $(".search-comment").html("絞り込みをする");
            $(".search-down").show();
            $(".search-up").hide();
        } else {
            $(".search-comment").html("検索を非表示");
            $(".search-down").hide();
            $(".search-up").show();
        }
    });
});

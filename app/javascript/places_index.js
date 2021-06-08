document.addEventListener("turbolinks:load", function () {
    $(".change-details").on("click", function(){
        $(".details").slideToggle();
        $('.change-details').toggleClass('active');
        if( $(".change-details").hasClass('active') ){
            $(".detail-comment").html("詳細条件を閉じる");
            $(".detail-down").hide();
            $(".detail-up").show();
        } else {
            $(".detail-comment").html("詳細条件を追加");
            $(".detail-down").show();
            $(".detail-up").hide();
        }
    });
  });
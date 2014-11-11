(function($) {
    var offset = $(".bradflix-sidebar").offset();
    var topPadding = 15;
    $(window).scroll(function() {
        if ($(window).scrollTop() > offset.top) {
            $(".bradflix-sidebar").stop().animate({
                marginTop: $(window).scrollTop() - offset.top + topPadding
            });
        } else {
            $(".bradflix-sidebar").stop().animate({
                marginTop: 0
            });
        };
    });
})(jQuery);
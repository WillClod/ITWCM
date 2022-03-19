var scroll = $(window).scrollTop();
$(window).scroll(function () {
    if ($('#option-1').prop('checked')) {
        transform('mdl-float-button', 'translate-up', 'translate-down');
    }
    else {
        transform('mdl-float-button', 'scale-one', 'scale-zero');
    }
})

function transform(selector, classOne, classTwo) {
    if ($('.' + selector).length !== 0) {
        if ($(window).scrollTop() > scroll) {
            $('.' + selector).removeClass(classOne);
            $('.' + selector).addClass(classTwo);
            scroll = $(window).scrollTop();
        }
        if ($(window).scrollTop() < scroll) {
            $('.' + selector).removeClass(classTwo);
            $('.' + selector).addClass(classOne);
            scroll = $(window).scrollTop();
        }
    }
}
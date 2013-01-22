$(document).ready(function() {
    $('.teaser-expand-link').bind('click', function() {
        $(this).parents('.teaser-column').find('.teaser-text').each(function() {
            $(this).removeClass('expanded').addClass('collapsed');
        });

        $(this).parents('.teaser-text').removeClass('collapsed').addClass('expanded');

        return false;
    });
});

$(document).ready(function() {
    var currentPosition = 0;
    var slideWidth = 876; //(876 + 20 margin left)
    var slides = $('.slide');
    var numberOfSlides = slides.length;

    // Wrap all .slides with #slideInner div
    slides.css('overflow', 'hidden').wrapAll('<div id="slideInner"></div>')
    
    // Float left to display horizontally, readjust .slides width
    .css({
        'float': 'left',
        'width': slideWidth
    });

    // Set #slideInner width equal to total width of all slides
    $('#slideInner').css('width', slideWidth * numberOfSlides);

    // Insert left and right arrow controls in the DOM
    $('.content-area.slide-show').prepend('<span class="control" id="leftControl">Move left</span>').append('<span class="control" id="rightControl">Move right</span>');

    // Create event listeners for .controls clicks
    $('.control').bind('click', function() {
        // Determine new position
        currentPosition = ($(this).attr('id') == 'rightControl') ? ((currentPosition + 1) % numberOfSlides) : ((currentPosition - 1));
        if (currentPosition == -1) currentPosition = (numberOfSlides - 1)

        // Move slideInner using margin-left
        $('#slideInner').animate({
            'marginLeft': slideWidth * (-currentPosition)
        });
    });
});

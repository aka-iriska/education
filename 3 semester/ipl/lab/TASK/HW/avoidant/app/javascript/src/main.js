$(document).on('click', '.btn-close', function () {
    $('.alert').fadeOut();
});

function send_request(value) {
    console.log('value:', value);
    $.ajax({
        url: 'http://localhost:3000/update_people',
        type: 'GET',
        dataType: 'script',
        data: {filter: value},
    });
}


$(document).ajaxSuccess(function (event, request, options, data) {
    let form_url = options.url
    console.log('ajaxSuccess', 'form url', form_url);

    if (form_url.includes('avoidant/people')) {
        send_request(data.value);
    }
});

window.onload = (event) => {
    const theme = localStorage.getItem('theme');

    if (!theme) {
        localStorage.setItem('theme', 'dark');
        console.log('Default theme set to dark');
    } else {
        $('#root').attr('data-bs-theme', theme);
    }

    $(document).on('click', '#theme_btn', function () {
        let theme = localStorage.getItem('theme');

        if (theme === 'dark') {
            theme = 'light';
        } else {
            theme = 'dark';
        }

        localStorage.setItem('theme', theme);
        $('#root').attr('data-bs-theme', theme);
        console.log('Theme changed to', theme)
    });
};

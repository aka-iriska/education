function client_side_process(data) {
    console.log('client_side_process', data);
    const result = document.getElementById("result");
    let str = '';

    try {
        str = new XMLSerializer().serializeToString(data.documentElement);
    } catch (e) {
        str = data;
    }

    result.innerHTML = "<hr/>Результат: " + str +
        "<hr/><p id='date'>" + Date() + "</p>";
}

// Сохраняем состояние приложения
function saveState(_state = null) {
    let server_radio = $("input:radio[id=server_radio]:checked").val();
    let n = document.getElementById("n").value;

    let state = '';
    if (!server_radio) {
        state = '0';
    } else {
        state = '1'
    }

    if (_state) {
        state = _state;
    }

    localStorage.setItem('server_radio', state);
    localStorage.setItem('input', n);

    console.log('State saved', state, n)
}

// Получаем состояние приложения
function getState() {
    return localStorage.getItem('server_radio');
}

// Восстанавливаем состояние приложения
function restoreState() {
    setFormDataRemote();
    setCheckboxState();
    setInputVal();
}


// Устанавливаем параметр `data-remote` для формы
function setFormDataRemote() {
    let calc_form = $('#calc_form');
    let state = getState();
    console.log('data-remote before:', calc_form.attr('data-remote'));

    if (state === '1') {
        console.log('Radio server');
        $(calc_form).attr('data-remote', false);
    } else {
        console.log('Radio client');
        $(calc_form).attr('data-remote', true);
    }

    console.log('data-remote after:', calc_form.attr('data-remote'));
}

// Устанавливаем состояние активного чекбокса
function setCheckboxState() {
    let state = getState();

    if (state === '1') {
        $("#server_radio").attr('checked', true)
    } else {
        $("#client_radio").attr('checked', true)
    }
}

// Задаем значение поля ввода из локального хранилища
function setInputVal() {
    document.getElementById("n").value = localStorage.getItem('input');
}

// Сохраняем состояние приложения по-умолчанию
function setDefaultState(state='1') {
    let localState = getState();

    if (!localState) {
        saveState(state); // устанавливаем чекбокс на сервер, если не стоит по умолчанию
    }
}

// Меняем action в зависимости от нажатой кнопки
$(document).on("click", 'input[id="xslt"]', function () {
    $("#calc_form").attr('action', '/twins_proxy/view.html');
});

$(document).on("click", 'input[id="xml"]', function () {
    $("#calc_form").attr('action', '/twins_proxy/view.xml');
});


$(document).ready(function () {
    setDefaultState();
    restoreState();

    console.log('Bind');
    $("#calc_form").bind("ajax:success",
        function (xhr, data, status) {
            console.log('ajax:success', $('#calc_form').attr('data-remote'))
            // console.log('ajax:success', xhr, data, status);
            client_side_process(data);
        })
})

// Перезагружаем страницу в случае смена чекбокса для сброса кэша
$(document).on("change", 'input[type="radio"]', function () {
    saveState();
    setFormDataRemote();

    // Костыль
    location.reload();
});

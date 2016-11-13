var Etapas = (function($) {

    var _fillCategoria = function() {
        var selected = $('#categoria_categoria_id').val();
        if (selected != "") {
            $('.modal #etapa_categoria_id').val(selected);
        }
    };

    var _filterByCategoria = function(categoria_id) {
        Utils.startLoading();
        $.get({
            url: window.location.pathname,
            dataType: "script",
            data: {"categoria_id": categoria_id}
        });
    };

    var _generateEtapas = function() {
        Utils.startLoading();
        $.ajax({
            method: 'POST',
            url: window.location.pathname + '/generate',
            dataType: 'json',
            success: function(data) {
                Utils.showResponse(data);
            },
            error: function(data) {
                Utils.showResponse(data.responseJSON);
            }
        });
    };

    var initEtapas = function() {

    };

    var init = function() {
        $('#categoria_categoria_id').on('change', function(event) {
            _filterByCategoria($(this).val());
        });

        $(".btn_etapas_generate").on('click', function(event) {
            event.preventDefault();
            _generateEtapas();
        });

        $(".btn_etapa_add").on('click', function(event) {
            event.preventDefault();
            _openModal();
            _fillCategoria();
        });
    }

    return {
        init: init,
        initEtapas: initEtapas
    };

})(jQuery);

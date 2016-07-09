var Campeonatos = (function($) {

    var _generateEvento = function() {
        Utils.startLoading();
        $.post({
            url: 'evento',
            dataType: 'json',
            success: function(data) {
                console.log(data)
                if (data.success) {
                    Utils.showMessage('success', data.message);
                } else {
                    Utils.showMessage('error', data.message);
                }
            }
        });
    };

    var init = function() {
        $('.btn_gen_evento').on('click', function(event) {
            event.preventDefault();
            _generateEvento();
        });
    }

    return {
        init: init
    };

})(jQuery);

var Gerencia = (function($) {

    var _generateProva = function() {
        var method = 'POST';
        $.ajax({
            method: method,
            url: window.location.pathname.replace("gerencia", "create_provas") , 
            dataType: "json",
            data: $(".modal #participant_form").serializeObject(),
            success: function(data) {
                if (data.success) {
                    _closeModal();
                    $('#categoria_categoria_id').trigger('change');
                } else {
                    // TODO display errors
                }
            }
        });
        // TODO display errors
    };

    var init = function() {
        
        $(".btn_generate_prova").on('click', function(event) {
            event.preventDefault();
            _generateProva();
        });
    };

    return {
        init: init,
    };

})(jQuery);

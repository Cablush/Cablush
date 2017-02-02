var Classificacao = (function($) {
    var _saveClassificacao = function() {
        if (_checkFieldsParticipantesModal()) {
            var url = window.location.pathname;
            var method = 'POST';
            var participante_uuid = $('#participante_uuid').val();
            if (participante_uuid.length > 0) {
                url = url + "/" + participante_uuid;
                method = 'PUT';
            }
            Utils.startLoading();
            $.ajax({
                method: method,
                url: url,
                dataType: "json",
                data: $("#participant_form").serializeObject(),
                success: function(data) {
                    if (data.success) {
                        _closeModal();
                        _clearForm();
                        $('#categoria_categoria_id').trigger('change');
                    }
                    Utils.showResponse(data);
                },
                error: function(data) {
                    Utils.showResponse(data.responseJSON);
                }
            });
        }
        // TODO display errors
    };

    var _checkFieldsParticipantesModal = function() {
        return $('#participante_categoria_id').val().length > 0
            && $("#participante_nome").val().length > 0
            && $("#participante_numero_inscricao").val().length > 0
            && $("#participante_classificacao").val().length > 0;
    };

    var _clearForm = function() {
        $('#participante_categoria_id').val("");
        $("#participante_nome").val("");
        $("#participante_numero_inscricao").val("");
        $("#participante_classificacao").val("");
    };

    var _openModal = function() {
        Utils.openModal('<div class="col_1_of_3 span_1_of_3">'
            + $('#modal_classificacao').html()
            + '</div>', function() {});
    };

    var _closeModal = function() {
        _clearForm();
        $(".modal").dialog("close");
    };


    var init = function() {
        initParticipantesDataTable();

        $(".btn_classificacao").on('click', function(event) {
            event.preventDefault();
            _openModal();
        });

        $(document.body).on('click', '.btn_participante_save', function(event) {
            event.preventDefault();
            _saveParticipante();
        });
    };

    return {
        init: init
    };

})(jQuery);

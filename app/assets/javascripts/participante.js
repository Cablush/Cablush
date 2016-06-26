var Participante = (function($) {

    var _fillCategoria = function() {
        var selected = $('#categoria_categoria_id').val();
        if (selected != "") {
            $('.modal #participante_categoria_id').val(selected);
        }
    };

    var _filterByCategoria = function(categoria_id) {
        var campeonato_uuid = $('#campeonato_uuid').val();
        Utils.startLoading();
        $.ajax({
            url: "/cadastros/campeonatos/" + campeonato_uuid + "/participantes",
            dataType: "script",
            data: {"categoria_id": categoria_id}
        });
    };

    var _openParticipante = function(participante_uuid) {
        var campeonato_uuid = $('#campeonato_uuid').val();
        Utils.startLoading();
        $.post({
            url: "/cadastros/campeonatos/" + campeonato_uuid
                + "/participantes/" + participante_uuid + "/edit",
            dataType: "script"
        });
    };

    var _saveParticipante = function() {
        if (_checkFieldsParticipantesModal()){
            var campeonato_uuid = $('#campeonato_uuid').val();
            $.post({
                url: "/cadastros/campeonatos/" + campeonato_uuid + "/participantes",
                dataType: "json",
                data: $(".modal #participant_form").serializeObject(),
                success: function(data) {
                    if (data.success) {
                        _closeModal();
                        _filterByCategoria(data.data["categoria_id"]);
                    } else {
                        // TODO display errors
                    }
                }
            });
        }
        // TODO display errors
    };

    var _checkFieldsParticipantesModal = function(){
        return $('.modal #participante_categoria_id').val().length > 0
            && $(".modal #participante_nome").val().length > 0
            && $(".modal #participante_numero_inscricao").val().length > 0
            && $(".modal #participante_classificacao").val().length > 0;
    }

    var _clearForm = function(){
        $('.modal #participante_categoria_id').val("");
        $(".modal #participante_nome").val("");
        $(".modal #participante_numero_inscricao").val("");
        $(".modal #participante_classificacao").val("");
    };

    var _openModal = function() {
        Utils.openModal('<div class="col_1_of_3 span_1_of_3">'
            + $('#modal_participantes').html()
            + '</div>', function() {});
    };

    var _closeModal = function() {
        _clearForm();
        $(".modal").dialog("close");
    };

    var init = function() {
        $('#categoria_categoria_id').on('change', function(event) {
            _filterByCategoria($(this).val());
        });

        $(".btn_participante_add").on('click', function(event) {
            event.preventDefault();
            _openModal();
            _fillCategoria();
        });

        // TODO edit call

        // TODO delete call

        $(document.body).on('click', '.btn_participante_save', function(event) {
            event.preventDefault();
            _saveParticipante();
        });
    };

    return {
        init: init
    };

})(jQuery);

var Participante = (function($) {

    var _selectCategoria = function() {
        var selected = $('#categoria_categoria_uuid').val();
        if (selected != "") {
            $('.modal #categoria_categoria_uuid').val(selected);
        }
    };

    var _filterByCategoria = function(categoria_uuid) {
        var campeonato_uuid = $('#campeonato_uuid').val();
        Utils.startLoading();
        $.ajax({
            url: "/cadastros/campeonatos/" + campeonato_uuid + "/participantes",
            dataType: "script",
            data: {"categoria_uuid": categoria_uuid}
        });
    };

    var _openParticipante = function(participante_uuid) {
        var campeonato_uuid = $('#campeonato_uuid').val();
        Utils.startLoading();
        $.post({
            url: "/cadastros/campeonatos/" + campeonato_uuid + "/participantes/show",
            dataType: "script",
            data: {"participante_uuid": participante_uuid}
        });
    };

    var _saveParticipante = function() {
        if (_checkFieldsParticipantesModal()){
            var campeonato_uuid = $('#campeonato_uuid').val();
            $.post({
                url: "/cadastros/campeonatos/" + campeonato_uuid + "/participantes/create",
                dataType: "script",
                data: $("#participant_form").serializeObject()
            });
            _closeModal()
        }
        // TODO display errors
    };

    var _checkFieldsParticipantesModal = function(){
        return $('.modal #categoria_categoria_uuid').val().length > 0
            && $(".modal #nome").val().length > 0
            && $(".modal #num_inscricao").val().length > 0
            && $(".modal #classificacao").val().length > 0;
    }

    var _clearForm = function(){
        $(".modal #nome").val("");
        $(".modal #num_inscricao").val("");
        $(".modal #classificacao").val("");
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
        $('#categoria_categoria_uuid').on('change', function(event) {
            _filterByCategoria($(this).val());
        });

        $(".btn_participante_add").on('click', function(event) {
            event.preventDefault();
            _openModal();
            _selectCategoria();
        });

        // TODO edit call

        // TODO delete call

        $(document.body).on('click', '.btn_participant_save', function(event) {
            event.preventDefault();
            _saveParticipante();
        });
    };

    return {
        init: init
    };

})(jQuery);

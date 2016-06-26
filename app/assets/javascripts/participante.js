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
        $.get({
            url: "/cadastros/campeonatos/" + campeonato_uuid + "/participantes",
            dataType: "script",
            data: {"categoria_id": categoria_id}
        });
    };

    var _openParticipante = function(participante_uuid) {
        var campeonato_uuid = $('#campeonato_uuid').val();
        _openModal();
        Utils.startLoading();
        $.get({
            url: "/cadastros/campeonatos/" + campeonato_uuid
                + "/participantes/" + participante_uuid + "/edit",
            dataType: "script"
        });
    };

    var _saveParticipante = function() {
        if (_checkFieldsParticipantesModal()) {
            var campeonato_uuid = $('#campeonato_uuid').val();
            var url = "/cadastros/campeonatos/" + campeonato_uuid + "/participantes";
            var method = 'POST';
            var participante_uuid = $('.modal #participante_uuid').val();
            if (participante_uuid.length > 0) {
                url = url + "/" + participante_uuid;
                method = 'PUT';
            }
            Utils.startLoading();
            $.ajax({
                method: method,
                url: url,
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
        }
        // TODO display errors
    };

    var _deleteParticipante = function() {
        var campeonato_uuid = $('#campeonato_uuid').val();
        var participante_uuid = $('.modal #participante_uuid').val();
        if (participante_uuid.length > 0) {
            Utils.startLoading();
            $.ajax({
                method: 'DELETE',
                url: "/cadastros/campeonatos/" + campeonato_uuid
                    + "/participantes/" + participante_uuid,
                success: function(data) {
                    _closeModal();
                    $('#categoria_categoria_id').trigger('change');
                }
            });
        }
    };

    var _checkFieldsParticipantesModal = function() {
        return $('.modal #participante_categoria_id').val().length > 0
            && $(".modal #participante_nome").val().length > 0
            && $(".modal #participante_numero_inscricao").val().length > 0
            && $(".modal #participante_classificacao").val().length > 0;
    };

    var _clearForm = function() {
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

    var initParticipantesDataTable = function() {
        $('.participantes_categoria').dataTable({
            searching: false,
            paging: false,
            info: false,
            columnDefs: [{targets: [0], visible: false}]
        });

        $('.participantes_categoria tbody').off('click');

        $('.participantes_categoria tbody').on('click', 'tr', function(event) {
            var dataTable = $(this).parent().parent().dataTable();
            var participante_uuid = dataTable.fnGetData(this)[0];
            _openParticipante(participante_uuid);
        });
    };

    var init = function() {
        initParticipantesDataTable();

        $('#categoria_categoria_id').on('change', function(event) {
            _filterByCategoria($(this).val());
        });

        $(".btn_participante_add").on('click', function(event) {
            event.preventDefault();
            _openModal();
            _fillCategoria();
        });

        $(document.body).on('click', '.btn_participante_save', function(event) {
            event.preventDefault();
            _saveParticipante();
        });

        $(document.body).on('click', '.btn_participante_delete', function(event) {
            event.preventDefault();
            // TODO delete confirmation
            _deleteParticipante();
        });
    };

    return {
        init: init,
        initParticipantes: initParticipantesDataTable
    };

})(jQuery);

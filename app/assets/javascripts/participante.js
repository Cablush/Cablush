var Participante = (function($) {

    var _fillCategoria = function() {
        var selected = $('#categoria_categoria_id').val();
        if (selected != "") {
            $('.modal #participante_categoria_id').val(selected);
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

    var _openParticipante = function(participante_uuid) {
        _openModal();
        Utils.startLoading();
        $.get({
            url: window.location.pathname + "/" + participante_uuid + "/edit",
            dataType: "script"
        });
    };

    var _saveParticipante = function() {
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

    var _deleteParticipante = function() {
        var participante_uuid = $('.modal #participante_uuid').val();
        if (participante_uuid.length > 0) {
            Utils.startLoading();
            $.ajax({
                method: 'DELETE',
                url: window.location.pathname + "/" + participante_uuid,
                success: function(data) {
                    _closeModal();
                    $('#categoria_categoria_id').trigger('change');
                }
            });
        }
    };

    var _allocateParticipants = function() {
        Utils.startLoading();
        $.ajax({
            method: 'POST',
            url: window.location.pathname + '/allocate',
            dataType: 'json',
            success: function(data) {
                Utils.showResponse(data);
            },
            error: function(data) {
                Utils.showResponse(data.responseJSON);
            }
        });
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

        $(".btn_participants_allocate").on('click', function(event) {
            event.preventDefault();
            _allocateParticipants();
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

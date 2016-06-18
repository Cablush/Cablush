var Participante = (function($) {

    var _selectParticipante = function() {
        if (_checkFieldsParticipantesModal()){
            $.ajax({
                method: 'POST',
                url: "/cadastros/campeonatos/"+$("#uuid").val()+"/save_participante",
                dataType: "json",
                data: $("#participant_form").serializeObject(),
                success: function(result){
                    //_clearForm();
                    console.log(result);
                    $(document.getElementById("list_participantes"))
                        .append('<ol>'+$('#classificacao').val()+'- '+$('#nome').val() +' </ol>');
                },
                error: function(error){
                    console.log(error);
                }
            });
        }
    };

    var _checkFieldsParticipantesModal = function(){
        return $("#nome").val().length > 0
            && $("#num_inscricao").val().length > 0
            && $("#classificacao").val().length > 0;
    }

    var _hideLightBox = function(){
        $('#light').hide();
        $('#fade').hide();
    };
    var _showLightBox = function(){
        $('#light').show();
        $('#fade').show();
    }

    var _clearForm = function(){
        $("#nome").val("");
        $("#num_inscricao").val("");
        $("#classificacao").val("");
    }

    var init = function() {
        $(".auto_btn_participante_add").on('click', function(event) {
            event.preventDefault();
            _selectParticipante();
            //_hideLightBox();
        });

        $("#lightbox_show").on('click',function(event){
            event.preventDefault();
            _showLightBox();
             //Todo ver como funciona o style.display no jquery
        });

        $("#lightbox_hide").on('click', function(event) {
            event.preventDefault();
            _hideLightBox();
        });
    }

    return {
        init: init
    };
})(jQuery);

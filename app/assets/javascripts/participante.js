var Participante = (function($) {

    var _selectParticipante = function() {
        if (_checkFieldsParticipantesModal()){
            participante_attribute= {
                nome: $("#nome").val(),
                num_inscricao: $("#num_inscricao").val(),
                classificacao: $("#classificacao").val(),
                categoria: $('#post_categoria_id').val()
            };
            $.ajax({ type: 'POST',
                contentType: "application/json",
                url: "/cadastros/campeonatos/"+$("#uuid").val()+"/save_participante", 
                data: participante_attribute,
                success: function(result){
                    console.log(result);
                    $(document.getElementById("list_participantes"))
                        .append('<ol>'+$('#classificacao').val()+'- '+$('#nome').val() +' </ol>');
                },
                error: function(error){
                    console.log(error);
                },
                dataType: "json"
            });          
            _clearForm();
            // Clear autocomplete values
        }
    };

    var _checkFieldsParticipantesModal = function(){
        return $("#nome").val().length > 0 && $("#num_inscricao").val().length > 0 && $("#classificacao").val().length > 0;
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

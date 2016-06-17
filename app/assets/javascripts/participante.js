var Participante = (function($) {

    var edit = -1;
    var _selectParticipante = function() {
        if (_checkFieldsParticipantesModal(item)){
            // Update new item values

            var item = _createParticipanteItem(edit);
            item.find("[id$='_nome']").val($('#nome').val());
            item.find("[id$='_num_inscricao']").val($('#num_inscricao').val());
            item.find("[id$='_classificacao']").val($('#classificacao').val());
            item.find("[id$='_categoria']").val($('#post_categoria_id').val());

            //insert item on ul list_participantes

            $(".list_participantes").append('<li><a href="/user/messages"><span class="tab">Message Center</span></a></li>');
            // Insert new item on list
            if(edit == -1){
                item.find("[id$='_id']").val("");
                item.insertAfter($(".participante_item").last());
            }
            _clearForm();
            edit= -1;
            // Clear autocomplete values
        }
    };


    var _createParticipanteItem = function() {
        // Clone last item and increment it index
        var item = $(".categoria_item").last().clone();

        item.find("input").attr("id", function(i, oldVal) {
            return _incrementIndex(i, oldVal);
        });
        item.find("input").attr("name", function(i, oldVal) {
            return _incrementIndex(i, oldVal);
        });
        item.attr('style', function(i, style) {
            if (style) {
                return style.replace(/display[^;]+;?/g, '');
            }
        });
        return item;
        
    };

    var _checkFieldsParticipantesModal = function(){
        return $("#nome").val().length > 0 && $("#num_inscricao").val().length > 0 && $("#classificacao").val().length > 0;
    }

    var _incrementIndex = function(i, oldVal) {
        if(oldVal == i){
            return val;
        }
        return oldVal.replace(/\d+/, function(val) {
            return +val+1;
        });
    };

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

        $(document.body).on('click', '.auto_btn_categoria_del', function(event) {
            event.preventDefault();
            $(this).parent().remove();
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

    var _fillFields = function(arrayFields){
        for(var i = 0; i < arrayFields.length; i++){
            if(arrayFields[i].value != undefined){
                if(arrayFields[i].id.indexOf("nome") > -1){
                    edit = parseInt(arrayFields[i].name.match(/\d+/));
                    $("#nome").val(arrayFields[i].value);
                }else if(arrayFields[i].id.indexOf("descricao") > -1){
                    $("#descricao").val(arrayFields[i].value);
                }else if(arrayFields[i].id.indexOf("regras") > -1){
                    $("#regras").val(arrayFields[i].value);
                }
            }
        }
    }

    return {
        init: init
    };
})(jQuery);

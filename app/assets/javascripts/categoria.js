var Categoria = (function($) {

    var _selectCategoria = function() {
        if (_checkFieldsCategoriaModal(item)){
            // Update new item values
            var item = _createCategoriaItem();
            // item.find("[id^='categoria_ids_']").val($('#auto_id').val());
            //item.find("[id$='_id']").val($('#auto_id').val());
            item.find("[id$='_nome']").val($('#nome').val());
            item.find("[id$='_regras']").val($('#regras').val());
            item.find("[id$='_descricao']").val($('#descricao').val());
            // Insert new item on list
            item.insertAfter($(".categoria_item").last());
            // Clear autocomplete values
            _clearForm();
        }
    };


    var _createCategoriaItem = function() {
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

    var _checkFieldsCategoriaModal = function(){
        return $("#nome").val().length > 0 && $("#regras").val().length > 0 && $("#descricao").val().length > 0;
    }

    var _incrementIndex = function(i, oldVal) {
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
        $("#regras").val("");
        $("#descricao").val("");
    }

    var init = function() {
        $(".auto_btn_categoria_add").on('click', function(event) {
            event.preventDefault();
            _selectCategoria();
            _hideLightBox();
        });

        $(document.body).on('click', '.auto_btn_categoria_del', function(event) {
            event.preventDefault();
            $(this).parent().remove();
        });

        $(document.body).on('click','.inputbox_auto',function(event){
            event.preventDefault();
            _fillFields($(this).parent()[0].childNodes);
            _showLightBox();
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

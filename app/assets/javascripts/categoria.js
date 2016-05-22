var Categoria = (function($) {
	
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

    var checkFieldsCategoriaModal = function(){
        return $("#nome").val().length > 0; // && $("").val().length > 0 && ("").val().length > 0;
    }

    var _selectEsporte = function() {
        var item = _createCategoriaItem();
        if (checkFieldsCategoriaModal(item)){
            // Update new item values
            item.find("[id^='categoria_ids_']").val($('#auto_id').val());
            item.find("[id$='_id']").val($('#auto_id').val());
            item.find("[id$='_nome']").val($('#nome').val());
            item.find("[id$='_categoria_regra']").val($('#regra').val());
            item.find("[id$='_categoria_descricao']").val($('#descricao').val());
            // Insert new item on list
            item.insertAfter($(".categoria_item").last());
            // Clear autocomplete values
            $('#auto_id').val("");
            $('#auto_esporte').val("");
            //clearForm();
        }
        
    };


    var _incrementIndex = function(i, oldVal) {
        return oldVal.replace(/\d+/, function(val) {
            return +val+1;
        });
    };

    var _hideLightBox = function(){
        $('#light').hide();
        $('#fade').hide();
    };

    var init = function() {
        $(".auto_btn_categoria_add").on('click', function(event) {
            event.preventDefault();
            _createCategoriaItem();
            _hideLightBox();
        });

        $(".auto_btn_categoria_del").on('click', function(event) {
            event.preventDefault();
            $(this).parent().remove();
        });
        
        $("#lightbox_show").on('click',function(event){
            event.preventDefault();
             $('#light').show();
             $('#fade').show();
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
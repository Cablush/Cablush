var Cadastros = (function($) {
	
	var _selectCategoria = function() {
        if ($('#auto_categoria').val().length > 0) {
            // Create a new item
            var item = _createCategoriaItem();
            // Update new item values
            item.find("[id^='categoria_ids_']").val($('#auto_id').val());
            item.find("[id$='_id']").val($('#auto_id').val());
            item.find("[id$='_nome']").val($('#auto_categoria').val());
            item.find("[id$='_categoria_esporte']").val($('#auto_categoria').val());
            // Insert new item on list
            item.insertAfter($(".esporte_item").last());
            // Clear autocomplete values
            $('#auto_id').val("");
            $('#auto_categoria').val("");
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

    var init = function() {
        $(".auto_btn_categoria_add").on('click', function(event) {
            event.preventDefault();
            _selectCategoria();
        });

        $(".auto_btn_categoria_del").on('click', function(event) {
            event.preventDefault();
            $(this).parent().remove();
        });
    
    }
    
}

    /*
    */
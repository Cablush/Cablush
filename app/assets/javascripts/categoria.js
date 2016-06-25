var Categoria = (function($) {

    var _addItemToList = function() {
        if (_validateModalFields(item)) {
            var index = $('.modal #index').val();
            // Update item values
            var item = _createItem(index);
            item.find("[id$='_id']").val($('.modal #id').val());
            item.find("[id$='_uuid']").val($('.modal #uuid').val());
            item.find("[id$='_nome']").val($('.modal #nome').val());
            item.find("[id$='_regras']").val($('.modal #regras').val());
            item.find("[id$='_descricao']").val($('.modal #descricao').val());
            // To new items, clear some fields and insert into list
            if (index == "") {
                item.find("[id$='_id']").val("");
                item.find("[id$='_uuid']").val("");
                item.find("[id$='_destroy']").val("");
                item.insertAfter($(".categoria_item").last());
            }
            // Close the modal
            _closeModal();
        }
        // TODO Show error message
    };

    var _createItem = function(index) {
        if (index != "") {
            // Get item to edit
            var item = $(".categoria_item").get(index);
            return $(item);
        } else {
            // Clone last item and increment its index
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
        }
    };

    var _validateModalFields = function() {
        return $(".modal #nome").val().length > 0
            && $(".modal #regras").val().length > 0
            && $(".modal #descricao").val().length > 0;
    };

    var _incrementIndex = function(i, oldVal) {
        if (oldVal != undefined) {
            return oldVal.replace(/\d+/, function(val) {
                return +val+1;
            });
        }
        return oldVal;
    };

    var _fillModalFields = function(arrayFields, index) {
        _openModal();
        $(".modal #index").val(index);
        for (var i = 0; i < arrayFields.length; i++) {
            if (arrayFields[i].value != undefined) {
                if (arrayFields[i].id.indexOf("uuid") > -1) {
                    $(".modal #uuid").val(arrayFields[i].value);
                } else if (arrayFields[i].id.indexOf("id") > -1) {
                    $(".modal #id").val(arrayFields[i].value);
                } else if (arrayFields[i].id.indexOf("nome") > -1) {
                    $(".modal #nome").val(arrayFields[i].value);
                } else if(arrayFields[i].id.indexOf("descricao") > -1) {
                    $(".modal #descricao").val(arrayFields[i].value);
                } else if(arrayFields[i].id.indexOf("regras") > -1) {
                    $(".modal #regras").val(arrayFields[i].value);
                }
            }
        }
    };

    var _clearModalFields = function() {
        $(".modal #id").val("");
        $(".modal #uuid").val("");
        $(".modal #nome").val("");
        $(".modal #regras").val("");
        $(".modal #descricao").val("");
    };

    var _openModal = function() {
        Utils.openModal('<div class="col_1_of_3 span_1_of_3">'
            + $('#modal_categorias').html()
            + '</div>', function() {});
    };

    var _closeModal = function() {
        _clearModalFields();
        $(".modal").dialog("close");
    };

    var init = function() {
        $('.btn_categoria_add').on('click', function(event) {
            event.preventDefault();
            _openModal();
        });

        $(document.body).on('click', '.inputbox_auto', function(event) {
            event.preventDefault();
            _fillModalFields($(this).parent()[0].childNodes,
                $('.inputbox_auto').index($(this)));
        });

        $(document.body).on('click', '.btn_categoria_save', function(event) {
            event.preventDefault();
            _addItemToList();
        });
    };

    return {
        init: init
    };

})(jQuery);

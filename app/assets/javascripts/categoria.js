var Categoria = (function($) {

    var edit = -1;

    var _selectCategoria = function() {
        if (_checkFieldsCategoriaModal(item)) {
            // Update new item values
            var item = _createCategoriaItem(edit);
            item.find("[id$='_nome']").val($('.modal #nome').val());
            item.find("[id$='_regras']").val($('.modal #regras').val());
            item.find("[id$='_descricao']").val($('.modal #descricao').val());
            // Insert new item on list
            if (edit == -1) {
                item.find("[id$='_id']").val("");
                item.insertAfter($(".categoria_item").last());
            }
            return true;
        }
        return false;
    };

    var _createCategoriaItem = function() {
        if (edit != -1) {
            // Clone last item and increment it index
            var item = $(".categoria_item").get(edit);
            return $(item);
        } else {
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
        }
    };

    var _checkFieldsCategoriaModal = function() {
        return $(".modal #nome").val().length > 0
            && $(".modal #regras").val().length > 0
            && $(".modal #descricao").val().length > 0;
    };

    var _incrementIndex = function(i, oldVal) {
        if (oldVal == i) {
            return val;
        }
        return oldVal.replace(/\d+/, function(val) {
            return +val+1;
        });
    };

    var _clearForm = function() {
        edit= -1;
        $(".modal #nome").val("");
        $(".modal #regras").val("");
        $(".modal #descricao").val("");
    };

    var _fillFields = function(arrayFields){
        for (var i = 0; i < arrayFields.length; i++) {
            if (arrayFields[i].value != undefined) {
                if (arrayFields[i].id.indexOf("nome") > -1) {
                    $(".modal #nome").val(arrayFields[i].value);
                } else if(arrayFields[i].id.indexOf("descricao") > -1) {
                    $(".modal #descricao").val(arrayFields[i].value);
                } else if(arrayFields[i].id.indexOf("regras") > -1) {
                    $(".modal #regras").val(arrayFields[i].value);
                }
            }
        }
    };

    var _openModal = function() {
        Utils.openModal('<div class="col_1_of_3 span_1_of_3">'
            + $('#modal_categorias').html()
            + '</div>', function() {});
    };

    var _closeModal = function() {
        _clearForm();
        $(".modal").dialog("close");
    };

    var init = function() {
        $('.btn_categoria_add').on('click', function(event) {
            event.preventDefault();
            _openModal();
        });

        $(document.body).on('click', '.inputbox_auto', function(event) {
            event.preventDefault();
            _openModal();
            _fillFields($(this).parent()[0].childNodes);
            edit = $('.inputbox_auto').index($(this));
        });

        $(document.body).on('click', '.btn_categoria_del', function(event) {
            event.preventDefault();
            $(this).parent().remove();
        });

        $(document.body).on('click', '.btn_categoria_save', function(event) {
            event.preventDefault();
            if (_selectCategoria()) {
                _closeModal();
            }
        });
    };

    return {
        init: init
    };

})(jQuery);

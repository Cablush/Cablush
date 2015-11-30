$(function() {
    
    var setAddress = function(data) {
        $('#local_estado').val(data.estado);
        $('#local_cidade').val(data.cidade);
        $('#local_bairro').val(data.bairro);
        $('#local_logradouro').val(data.logradouro);
        $('#local_logradouro').trigger('change');
    };
    
    // Pesquisa de endereço por CEP
    $('#local_cep').on('change', function () {
        $.getJSON("http://api.postmon.com.br/v1/cep/" + $(this).val(), function(data) {
            setAddress(data);
        });
    });
    
    // Autocomplete de cidade
    $('#local_cidade').bind('railsAutocomplete.select', function(event, data) {
        if (data.item.estado !== $('#local_estado').val()) {
            $('#local_estado').val(data.item.estado);
        }
    });
    
    // Autocomplete de esporte
    $('#auto_esporte').bind('railsAutocomplete.select', function(event, data) {
        $('#auto_id').val(data.item.id);
        $('#auto_esporte').val(data.item.value);
    });
    var createItem = function() {
        // Clone last item and increment it index
        var item = $(".esporte_item").last().clone();
        item.find("input").attr("id", function(i, oldVal) {
            return incrementIndex(i, oldVal);
        });
        item.find("input").attr("name", function(i, oldVal) {
            return incrementIndex(i, oldVal);
        });
        item.attr('style', function(i, style) {
            if (style) {
                return style.replace(/display[^;]+;?/g, '');
            }
        });
        return item;
    };
    var incrementIndex = function(i, oldVal) {
        return oldVal.replace(/\d+/, function(val) {
            return +val+1;
        });
    };
    $(".auto_btn_add").on('click', function(event) {
        event.preventDefault();
        if ($('#auto_esporte').val().length > 0) {
            // Create a new item
            var item = createItem();
            // Update new item values
            item.find("[id^='esporte_ids_']").val($('#auto_id').val());
            item.find("[id$='_id']").val($('#auto_id').val());
            item.find("[id$='_nome']").val($('#auto_esporte').val());
            item.find("[id$='_categoria_esporte']").val($('#auto_esporte').val());
            // Insert new item on list
            item.insertAfter($(".esporte_item").last());
            // Clear autocomplete values
            $('#auto_id').val("");
            $('#auto_esporte').val("");
        }
    });
    $(".auto_btn_del").on('click', function(event) {
        event.preventDefault();
        $(this).parent().remove();
    });
    
    // Textarea counter
    $('.textarea-box').on('keyup change', function() {
        if ($(this).parent().find('.textcount > span').length) {
            $(this).parent().find('.textcount > span')
                    .text($(this).attr('maxlength') - $(this).val().length);
        }
    });
    $('.textarea-box').trigger('change');

});

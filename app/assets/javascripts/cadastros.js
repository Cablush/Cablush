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

});

var search = function (url, estado, esporte) {
    $.ajax({
        url: url,
        dataType: "script",
        data: {
            estado: estado,
            esporte: esporte,
            filter: true
        }
    });
};

var setAddress = function(data) {
    $('#local_estado').val(data.estado);
    $('#local_cidade').val(data.cidade);
    $('#local_bairro').val(data.bairro);
    $('#local_logradouro').val(data.logradouro);
    $('#local_logradouro').trigger('change');
};

$(function () {
    
    // CADASTRO Pesquisa endereço por CEP
    $('#local_cep').on('change', function () {
        $.getJSON("http://api.postmon.com.br/v1/cep/" + $(this).val(), function(data) {
            setAddress(data);
        });
    });
    
    // CADASTRO Autocomplete Cidade
    $('#local_cidade').bind('railsAutocomplete.select', function(event, data) {
        if (data.item.estado !== $('#local_estado').val()) {
            $('#local_estado').val(data.item.estado);
        }
    });
    
    // LOJAS $('home lojas')
    $("#_home_lojas_estado, #_home_lojas_esporte").on('change', function () {
        search("lojas", $("#_home_lojas_estado").val(), $("#_home_lojas_esporte").val());
    });
    
    $('#limpar_campos').on('click', function () {
        $('#_home_lojas_estado').val('');
        $('#_home_lojas_esporte').val('').trigger('change');
    });
    
    // PISTAS $('home pistas')
    $("#_home_pistas_estado, #_home_pistas_esporte").on('change', function () {
        search("pistas", $("#_home_pistas_estado").val(), $("#_home_pistas_esporte").val());
    });
    
    $('#limpar_campos').on('click', function () {
        $('#_home_pistas_estado').val('');
        $('#_home_pistas_esporte').val('').trigger('change');
    });
    
    // EVENTOS $('home eventos')
    $("#_home_eventos_estado, #_home_eventos_esporte").on('change', function () {
        search("eventos", $("#_home_eventos_estado").val(), $("#_home_eventos_esporte").val());
    });
    
    $('#limpar_campos').on('click', function () {
        $('#_home_eventos_estado').val('');
        $('#_home_eventos_esporte').val('').trigger('change');
    });
    
});
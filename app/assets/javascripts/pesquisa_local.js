function search(url, estado, esporte) {
    $.ajax({
        url: url,
        dataType: "script",
        data: {
            estado: estado,
            esporte: esporte,
            filter: true
        }
    });
}

$(document).ready(function () {
    
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
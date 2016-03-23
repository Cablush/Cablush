$(function() {
    
    var searchLocal = function (url, estado, esporte) {
        Utils.startLoading();
        Utils.clearMessage();
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
    
    // LOJAS $('lojas')
    $("#_lojas_estado, #_lojas_esporte").on('change', function () {
        searchLocal("/lojas", $("#_lojas_estado").val(), $("#_lojas_esporte").val());
    });
    
    $('#limpar_campos').on('click', function () {
        $('#_lojas_estado').val('');
        $('#_lojas_esporte').val('').trigger('change');
    });
    
    // PISTAS $('pistas')
    $("#_pistas_estado, #_pistas_esporte").on('change', function () {
        searchLocal("/pistas", $("#_pistas_estado").val(), $("#_pistas_esporte").val());
    });
    
    $('#limpar_campos').on('click', function () {
        $('#_pistas_estado').val('');
        $('#_pistas_esporte').val('').trigger('change');
    });
    
    // EVENTOS $('eventos')
    $("#_eventos_estado, #_eventos_esporte").on('change', function () {
        searchLocal("/eventos", $("#_eventos_estado").val(), $("#_eventos_esporte").val());
    });
    
    $('#limpar_campos').on('click', function () {
        $('#_eventos_estado').val('');
        $('#_eventos_esporte').val('').trigger('change');
    });
    
    // Pagination
    if ($('.pagination').length) {
        $(window).on('scroll', function () {
            var url = $('.pagination a[rel=next]').attr('href');
            if (url && $(window).scrollTop() > ($(document).height() / 2) - $(window).height() - 50) {
                $('.pagination').text('Carregando...');
                Utils.startLoading();
                return $.ajax({
                    url: url,
                    dataType: "script"
                });
            }
        });
    }
    
    // Dialogs
    $('.lnk_dialog').on('click', function(e) {
       e.preventDefault();
       Utils.openDialog($(this).attr('href'));
    });
    
    // Fancybox
    $("a.fancybox").fancybox();
    $('.fancybox-media').fancybox({
        openEffect  : 'none',
        closeEffect : 'none',
        helpers : {
            media : {}
        }
    });
    
});

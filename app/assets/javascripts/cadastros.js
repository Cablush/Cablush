var Cadastros = (function($) {
    
    var _setAddress = function(data) {
        $('#local_estado').val(data.estado);
        $('#local_cidade').val(data.cidade);
        $('#local_bairro').val(data.bairro);
        $('#local_logradouro').val(data.logradouro);
        $('#local_logradouro').trigger('change');
    };
    
    var _getEstadoCode = function(data, code) {
        for (var index in data) {
            if (data[index].lang == 'abbr') {
                return data[index].name;
            }
        }
        return code;
    };
    
    var _getEstadoName = function(data) {
        if (data.adminName1 != null && data.adminName1 != "") {
            return data.adminName1;
        }   
        return data.name;
    };
    
    var _setEstados = function(data, currentEstado) {
        if (data instanceof String) {
            data = $.parseJSON(data);
        }
        $('#local_estado').empty();
        $('#local_estado').append('<option value="">Selecione o Estado</option>');
        $(data.geonames).each(function(index, value) {
            $('#local_estado').append('<option value=' 
                    + _getEstadoCode(value.alternateNames, value.adminCode1) + '>' 
                    + _getEstadoName(value) + '</option>');
        });
        if (currentEstado != null) {
            $('#local_estado').val(currentEstado);
            $('#local_estado').trigger('change');
        }
    };
    
    var _createEsporteItem = function() {
        // Clone last item and increment it index
        var item = $(".esporte_item").last().clone();
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
    
    var _selectEsporte = function() {
        if ($('#auto_esporte').val().length > 0) {
            // Create a new item
            var item = _createEsporteItem();
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
    };
    
    var _incrementIndex = function(i, oldVal) {
        return oldVal.replace(/\d+/, function(val) {
            return +val+1;
        });
    };
    
    var _setup = function() {
        // Configura Pais e Estado
        if ($('#local_pais').val() == '') { 
            $('#local_pais').val('BR');
        } else if ($('#local_pais').val() != 'BR') { 
            var currentEstado = $('#local_estado').val();
            $('#local_pais').trigger('change', currentEstado);
        }  
    };
    
    var init = function() {
        // Configure genames user
        jeoquery.defaultData.userName = window.geonames_user;
        
        // Pesquisa estados pelo pais
        $('#local_pais').on('change', function(event, currentEstado) {
            Utils.startLoading();
            $('#local_estado').empty();
            jeoquery.getGeoNames('search', 
                                 { country: $(this).val(), featureCode:'ADM1', style:'FULL' }, 
                                 function(data) {
                Utils.stopLoading();
                _setEstados(data, currentEstado);
            });
        });
                
        // Pesquisa de endereço por CEP
        $('#local_cep').on('change', function (event) {
            Utils.startLoading();
            $.getJSON("http://api.postmon.com.br/v1/cep/" + $(this).val(), function(data) {
                _setAddress(data);
            });
        });
        
        // Mudança de estado
        $('#local_estado').on('change', function(event) {
            $('#local_estado_nome').val($("#local_estado option:selected").text());
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
            _selectEsporte();
        });
        $(".auto_btn_add").on('click', function(event) {
            event.preventDefault();
            _selectEsporte();
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
        
        // Field Masks
        var brTelMaskBehavior = function (val) {
            return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
        },
        brOptions = {
            onKeyPress: function(val, e, field, options) {
                field.mask(brTelMaskBehavior.apply({}, arguments), options);
            }
        };
        //$('.maskTel').mask(brTelMaskBehavior, brOptions);
        //$(".maskCep").mask('00000-000');
        $(".maskData").mask('00/00/0000');
        
        _setup();
    };
    
    return {
        init: init
    };

})(jQuery);

// BEGIN LOJAS
$(document).ready(function() {
   $("#_home_lojas_estado").change(function() {
      $.ajax({
            url: "lojas",
            dataType: "script",
            data: { estado: $("#_home_lojas_estado").val(), esporte: $("#_home_lojas_esporte").val(), filter: true  }
          });
    });
  });


$(document).ready(function() {
   $("#_home_lojas_esporte").change(function() {
      $.ajax({
            url: "lojas",
            dataType: "script",
            data: { estado: $("#_home_lojas_estado").val(), esporte: $("#_home_lojas_esporte").val(), filter: true  }
          });
    });
  });
 // END LOJAS
 //BEGIN PISTAS
  $(document).ready(function() {
   $("#_home_pistas_estado").change(function() {
      $.ajax({
            url: "pistas",
            dataType: "script",
            data: { estado: $("#_home_pistas_estado").val(), esporte: $("#_home_pistas_esporte").val(), filter: true  }
          });
    });
  });


$(document).ready(function() {
   $("#_home_pistas_esporte").change(function() {
      $.ajax({
            url: "pistas",
            dataType: "script",
            data: { estado: $("#_home_pistas_estado").val(), esporte: $("#_home_pistas_esporte").val(), filter: true  }
          });
    });
  });
  
 // END PISTAS
 //BEGIN EVENTOS
  $(document).ready(function() {
   $("#_home_eventos_estado").change(function() {
      $.ajax({
            url: "eventos",
            dataType: "script",
            data: { estado: $("#_home_eventos_estado").val(), esporte: $("#_home_eventos_esporte").val(), filter: true  }
          });
    });
  });


$(document).ready(function() {
   $("#_home_eventos_esporte").change(function() {
      $.ajax({
            url: "eventos",
            dataType: "script",
            data: { estado: $("#_home_eventos_estado").val(), esporte: $("#_home_eventos_esporte").val(), filter: true  }
          });
    });
  });
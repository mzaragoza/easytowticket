//= require jquery
//= require migrate/jquery-migrate
//= require jquery_ujs
//= require users/jui/js/jquery-ui-1.9.2
//= require users/jui/jquery-ui.custom
//= require users/bootstrap/js/bootstrap
//= require users/libs/jquery.placeholder
//= require users/libs/jquery.mousewheel
//= require uniform/jquery.uniform
//= require autosize/jquery.autosize
//= require rating/jquery.rating
//= require picklist/picklist
//= require users/template
//= require users/setup
//= require users/customizer
//= require users/jui/timepicker/jquery-ui-timepicker
//= require users/jui/jquery.ui.touch-punch
//= require flot/jquery.flot
//= require flot/plugins/jquery.flot.tooltip
//= require flot/plugins/jquery.flot.pie
//= require flot/plugins/jquery.flot.resize
//= require circular-stat/circular-stat
//= require sparkline/jquery.sparkline
//= require ibutton/jquery.ibutton
//= require fullcalendar/fullcalendar
//= require bootstrap-wysihtml5
//= require datatables/jquery.dataTables
//= require datatables/TableTools/js/TableTools
//= require datatables/dataTables.bootstrap
//= require wizard/wizard
//= require wizard/jquery.form
//= require users/demo/form_wizard
//= require users/demo/dashboard
//= require validate/jquery.validate
//= require validate/jquery.validate.additional-methods.min
//= require select2/select2
//= require bootstrap-fileinput
//= require connect/ssValidate-0.5
//= require cleditor/jquery.cleditor
//= require cleditor/jquery.cleditor.icon
//= require cleditor/jquery.cleditor.table
//= require cleditor/jquery.cleditor-xhtml
//= require pnotify/jquery.pnotify
//= require intlTelInput.js

//= require jquery-minicolors
//= require jquery-minicolors-simple_form
//= require reveal
//
//= require hamlcoffee
//= require underscore
//= require_tree ../plugins
//= require backbone
//
//= require answeringServiceCare
//= require_tree ../templates
//= require ../views/admins
//= require_tree ../views
//
//= require autopopulate_zip_codes

$(document).ready(function() {
  $( '.cleditor').cleditor({
    width: '100%',
    controls: "bold italic underline strikethrough highlight | size style | removeformat | undo redo | rule cut copy paste pastetext   | source"
  });

  if($.fn.select2) {
    $( '.select2-select' ).select2();
  }

  $('input.string').click(function() {
    $(this).select();
  });
});
(function( $, window, document, undefined ) {
  var demos = {
    dtFixedColumns: function( target ) {
      if( $.fn.dataTable ) {
        var dt = target.dataTable({
              "sScrollY": "300px",
              "sScrollX": "100%",
              "sScrollXInner": "150%",
              "bScrollCollapse": true,
              "bPaginate": false
          });
        new FixedColumns( dt );
      }
    }
  };
  $(document).ready(function() {
    if($.fn.dataTable) {
      $('table#dtable').dataTable();
    }
  });
}) (jQuery, window, document);


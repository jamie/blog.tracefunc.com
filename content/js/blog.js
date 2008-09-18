$(document).ready(function() {
  $("pre code").parent().each(function() {
    $(this).addClass('prettyprint');
  });

  prettyPrint();
});

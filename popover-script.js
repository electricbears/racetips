<script>
  function loadContent(templateFile) {
    return $('<div>').load(templateFile, function(html) {
        parser = new DOMParser();
        doc = parser.parseFromString(html, "text/html");
        return doc.querySelector('h1').outerHTML + doc.querySelector('body').outerHTML;
    })
}
$('[data-toggle="popover"]').popover({
    html : true,
    content : function() {
        return loadContent($(this).data('templatefile'))
    }
});
</script>

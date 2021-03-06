function setUpNameParentTypeahead() {
    if (typeof(nameParentSuggestions) != "undefined") {
        $("#name-parent-typeahead").typeahead({highlight: true}, {
            name: "preceding-name-id-parent",
            displayKey: function(obj) {
                return obj.value;
            },
            source: nameParentSuggestions.ttAdapter()})
            .on('typeahead:opened', function($e,datum) {
                debug('typeahead:opened');
            })
            .on('typeahead:selected', function($e,datum) {
                debug('typeahead:selected');
                $('#name_parent_id').val(datum.id) })
            .on('typeahead:autocompleted', function($e,datum) {
                debug('typeahead:autocompeted');
                $('#name_parent_id').val(datum.id) })
        ;
    };
}


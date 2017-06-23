
var client = algoliasearch("T9LH1UH1AV", "ffa5ba6f2753d14dc4ab0f8930a07368")
var index = client.initIndex('kotlinresources');
var searchInput = document.getElementById("aa-search-input");
var inputContainer = document.getElementById("aa-input-container");

autocomplete('#aa-search-input', {
  hint: false,
  debug: true,
  openOnFocus: false
}, [{
    source: autocomplete.sources.hits(index, {hitsPerPage: 5}),
    displayKey: 'title',
    templates: {
      suggestion: function(suggestion) {
        return suggestion._highlightResult.title.value +
         "<div>" + suggestion._highlightResult.tags[0].value + "</div>";
      }
    }
  }
]).on('autocomplete:selected', function(event, suggestion, dataset) {
  window.location.href = suggestion.url
}).on('autocomplete:updated', function() {
    if (searchInput.value.length > 0) {
        inputContainer.classList.add("input-has-value");
    }
    else {
        inputContainer.classList.remove("input-has-value");
    }
})

//Handle clearing the search input on close icon click
document.getElementById("icon-close").addEventListener("click", function() {
    searchInput.value = "";
    inputContainer.classList.remove("input-has-value");
    document.getElementsByClassName("aa-dropdown-menu")[0].style.display = 'none';
});

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

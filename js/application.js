
var client = algoliasearch("T9LH1UH1AV", "ffa5ba6f2753d14dc4ab0f8930a07368")
var title = client.initIndex('kotlinresources');
var searchInput = document.getElementById("aa-search-input");
var inputContainer = document.getElementById("aa-input-container");

autocomplete('#aa-search-input', {
  autoselect: true,
  hint: false,
  debug: false,
  openOnFocus: false,
  dropdownMenu:
    '<div class="aa-dataset-libs"></div>'
}, [
      {
          source: autocomplete.sources.hits(title, {hitsPerPage: 5}),
          displayKey: 'title',
          templates: {
            suggestion: function(suggestion) {
              console.log(suggestion);
              return "<div style='color:#0275d8!important;font-size:1.3rem'>" + suggestion._highlightResult.title.value + "</div>" +
               "<div>" + suggestion._highlightResult.description.value + "</div>";
            },
            empty: '<div class="aa-empty">No matching libs</div>'
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

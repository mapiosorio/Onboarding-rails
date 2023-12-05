import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ['checkbox'];

  filterProducts() {
    const currentURL = window.location.href;
    // get category id form the URL
    const urlParts = currentURL.split('/');
    const idIndex = urlParts.indexOf('categories') + 1;
    const categoryId = urlParts[idIndex];

    // get sort option from the URL
    const url = new URL(currentURL);
    const searchParams = url.searchParams;
    const sortValue = searchParams.get('sort');

    const checkedCheckboxes = this.checkboxTargets.filter(checkbox => checkbox.checked);

    const filterParams = {};
    checkedCheckboxes.forEach(checkbox => {
      filterParams[checkbox.id] = checkbox.checked;
    });

    const requestData = {
      sortValue: sortValue,
      categoryId: categoryId,
      filterParams: filterParams
    };

    fetch(`/categories/${categoryId}/filter`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(requestData),
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html);
    })
  }
}

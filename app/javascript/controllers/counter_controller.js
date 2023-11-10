import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="counter"
export default class extends Controller {
  static targets = ['quantity', 'total', 'checkbox'];

  increment() {
    this.quantityTarget.value++;
    this.updateTotal();
  }

  decrement() {
    if (this.quantityTarget.value > 0) {
      this.quantityTarget.value--;
      this.updateTotal();
    }
  }

  additionalsCost() {
    let additionalCost = 0;
    this.checkboxTargets.forEach((checkbox) => {
      if (checkbox.checked) {
        const price = parseFloat(checkbox.dataset.price)
        additionalCost += price;
      }
    });
    return additionalCost;
  }

  updateTotal() {
    const productPrice = parseFloat(this.element.getAttribute("data-productPrice"));
    const quantity = parseFloat(this.quantityTarget.value);
    const additionals = this.additionalsCost();
    const total = quantity * productPrice + additionals;
    this.totalTarget.innerHTML = `$${total}`;
    document.getElementById('total-input').value = total + 0.20 * total;
  }
}

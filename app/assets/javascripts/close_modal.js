const modal = document.getElementById('card-modal');
if (modal) {
  modal.classList.remove('show');
  const modalBackdrop = document.querySelector('.modal-backdrop');
  const bodyElement = document.body;
  modalBackdrop.remove();
  bodyElement.removeAttribute('class');
  bodyElement.removeAttribute('style');
}

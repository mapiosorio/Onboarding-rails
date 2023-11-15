var myModal = document.getElementById('cardModal');
if (myModal) {
  myModal.classList.remove('show');
  const modalBackdrop = document.querySelector('.modal-backdrop');
  const bodyElement = document.body;
  modalBackdrop.remove();
  bodyElement.removeAttribute('class');
  bodyElement.removeAttribute('style');
}

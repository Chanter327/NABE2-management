const preButton = document.querySelector('.go-pre');
const nextButton = document.querySelector('.go-next');

const urlParams = new URLSearchParams(window.location.search);
const year = urlParams.get('year');
const month = urlParams.get('month');
const userId = urlParams.get('')
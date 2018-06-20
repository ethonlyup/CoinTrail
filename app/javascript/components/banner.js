
import Typed from 'typed.js';
// if (window.location.pathname == '/') {
function loadDynamicBannerText() {
  new Typed('#typed6', {
    stringsElement: '#typed-strings',
    // strings: ["Track your Crypto Portfolio^1000\n `Across Any Exchange`"],
    // strings: ['npm install^1000\n `installing components...` ^1000\n `Fetching from source...`'],
    typeSpeed: 50,
    backSpeed: 0,
    loop: true
  });
}

export { loadDynamicBannerText };
// };
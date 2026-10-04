const fs = require('fs');
const s = fs.readFileSync('C:/wamp64/www/360tech/School360tech/_live_flutter_bootstrap.js', 'utf8');
console.log('len', s.length);
console.log('start', s.slice(0,200));
console.log('end', s.slice(-500));

/** Core type and utility helpers */
function isObject(val) { 
  return val !== null && typeof val === 'object' && !Array.isArray(val); 
}
function deepClone(obj) { 
  return JSON.parse(JSON.stringify(obj)); 
}
module.exports = { isObject, deepClone };

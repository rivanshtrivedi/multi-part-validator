const core = require('./core');
function validateStructure(schema, target) {
  if (!core.isObject(target)) return { isValid: false, errors: ['Target must be an object'] };
  let errors = [];
  for (const key in schema) {
    if (schema[key].required && !(key in target)) errors.push(`Missing: ${key}`);
  }
  return { isValid: errors.length === 0, errors };
}
module.exports = { validateStructure };

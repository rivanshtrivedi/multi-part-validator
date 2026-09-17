@echo off
echo Creating multi-part project layout...
mkdir src
mkdir tests

echo Writing Part 1: Core Utilities...
(
echo /** Core type and utility helpers */
echo function isObject^(val^) { return val !== null ^&^& typeof val === 'object' ^&^& !Array.isArray^(val^); }
echo function deepClone^(obj^) { return JSON.parse^(JSON.stringify^(obj^)^); }
echo module.exports = { isObject, deepClone };
) > src\core.js

echo Writing Part 2: Validator Manager...
(
echo const core = require^('./core'^);
echo function validateStructure^(schema, target^) {
echo   if ^(!core.isObject^(target^)^) return { isValid: false, errors: ['Target must be an object'] };
echo   let errors = [];
echo   for ^(const key in schema^) {
echo     if ^(schema[key].required ^&^& !^(key in target^)^) errors.push^(`Missing: ${key}`^);
echo   }
echo   return { isValid: errors.length === 0, errors };
echo }
echo module.exports = { validateStructure };
) > src\validator.js

echo Writing Part 3: Connected Tests...
(
echo const { validateStructure } = require^('../src/validator'^);
echo test^('Validates correctly', ^(^) =^> {
echo   const schema = { id: { required: true } };
echo   expect^(validateStructure^(schema, { id: 1 }^).isValid^).toBe^(true^);
echo }^);
) > tests\validator.test.js

echo Writing Configuration Framework...
(
echo {
echo   "name": "multi-part-validator",
echo   "version": "1.0.0",
echo   "main": "src/validator.js",
echo   "scripts": { "test": "jest" },
echo   "devDependencies": { "jest": "^29.7.0" }
echo }
) > package.json

echo Project initialization complete!
pause

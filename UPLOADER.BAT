@echo off
echo Cleaning old setup files...
del /q setup.bat setup.sh 2>nul
rd /s /q src tests 2>nul

echo Creating fresh clean project folders...
mkdir src
mkdir tests

echo Writing Part 1: core.js...
(
echo function isObject^(val^) { return val !== null ^&^& typeof val === 'object' ^&^& !Array.isArray^(val^); }
echo function deepClone^(obj^) { return JSON.parse^(JSON.stringify^(obj^)^); }
echo module.exports = { isObject, deepClone };
) > src\core.js

echo Writing Part 2: validator.js...
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

echo Writing Part 3: validator.test.js...
(
echo const { validateStructure } = require^('../src/validator'^);
echo test^('Validates correctly', ^(^) =^> {
echo   const schema = { id: { required: true } };
echo   expect^(validateStructure^(schema, { id: 1 }^).isValid^).toBe^(true^);
echo }^);
) > tests\validator.test.js

echo Process complete! Look inside your folder now.
pause

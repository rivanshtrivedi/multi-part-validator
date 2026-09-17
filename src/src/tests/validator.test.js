const { validateStructure } = require('../src/validator');
test('Validates correctly', () => {
  const schema = { id: { required: true } };
  expect(validateStructure(schema, { id: 1 }).isValid).toBe(true);
});

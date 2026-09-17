#!/bin/bash
# Scaffolding script for Codex OSS Application Repository

echo "Creating project directory structure..."
mkdir -p src tests

# 1. Create package.json
cat << 'EOF' > package.json
{
  "name": "codex-oss-utility-kit",
  "version": "1.0.0",
  "description": "A multi-module JavaScript toolkit for advanced schema validation and data cloning utilities.",
  "main": "src/validator.js",
  "scripts": {
    "test": "jest"
  },
  "keywords": ["validation", "utility", "oss", "codex"],
  "author": "Open Source Maintainer",
  "license": "MIT",
  "devDependencies": {
    "jest": "^29.7.0"
  }
}
EOF

# 2. Create src/core.js (Part 1: Core Utilities)
cat << 'EOF' > src/core.js
/**
 * Part 1: Core Base Utilities Module
 */

/**
 * Gets the precise runtime type of a value
 * @param {*} value 
 * @returns {string}
 */
function getType(value) {
  if (value === null) return 'null';
  if (Array.isArray(value)) return 'array';
  return typeof value;
}

/**
 * Deep clones an object safely
 * @param {Object} obj 
 * @returns {Object}
 */
function deepClone(obj) {
  if (obj === null || typeof obj !== 'object') return obj;
  return JSON.parse(JSON.stringify(obj));
}

module.exports = {
  getType,
  deepClone
};
EOF

# 3. Create src/validator.js (Part 2: Schema Validator using Core utilities)
cat << 'EOF' > src/validator.js
/**
 * Part 2: High-Level Validation Module
 * Demonstrates internal multi-module connectivity
 */
const { getType, deepClone } = require('./core');

/**
 * Validates data against a structured ruleset schema
 * @param {Object} schema 
 * @param {Object} data 
 * @returns {Object} { isValid: boolean, errors: string[] }
 */
function validate(schema, data) {
  const errors = [];
  const clonedData = deepClone(data);

  if (!clonedData || typeof clonedData !== 'object') {
    return { isValid: false, errors: ['Target dataset must be an object'] };
  }

  for (const field in schema) {
    const rules = schema[field];
    
    if (rules.required && !(field in clonedData)) {
      errors.push(`Missing required field: '${field}'`);
      continue;
    }

    if (field in clonedData && rules.type) {
      const currentType = getType(clonedData[field]);
      if (currentType !== rules.type) {
        errors.push(`Field '${field}' expected type '${rules.type}', but found '${currentType}'`);
      }
    }
  }

  return {
    isValid: errors.length === 0,
    errors
  };
}

module.exports = {
  validate
};
EOF

# 4. Create tests/validator.test.js (Part 3: Testing Pipeline)
cat << 'EOF' > tests/validator.test.js
/**
 * Part 3: Test Suite Module verifying connectivity
 */
const { validate } = require('../src/validator');

describe('Multi-Module Toolkit Validation Tests', () => {
  const accountSchema = {
    accountId: { type: 'number', required: true },
    roles: { type: 'array', required: true },
    meta: { type: 'object', required: false }
  };

  it('should validate structured multi-part connected modules accurately', () => {
    const correctPayload = {
      accountId: 98765,
      roles: ['admin', 'maintainer'],
      meta: { active: true }
    };

    const outcome = validate(accountSchema, correctPayload);
    expect(outcome.isValid).toBe(true);
  });

  it('should catch validation failures successfully', () => {
    const brokenPayload = {
      accountId: 'string_instead_of_number',
      meta: {}
    };

    const outcome = validate(accountSchema, brokenPayload);
    expect(outcome.isValid).toBe(false);
    expect(outcome.errors.length).toBeGreaterThan(0);
  });
});
EOF

# 5. Create README.md
cat << 'EOF' > README.md
# Codex OSS Utility Kit 🛠️

A structural JavaScript utility application divided into dedicated core and validation modules.

## Architectural Paths
- `src/core.js`: Base level system type parsing and deep memory allocation cloning.
- `src/validator.js`: Secondary orchestration layer executing schemas by importing core utilities.
- `tests/validator.test.js`: Isolated framework automated assertion checks.

## Setup
Install dependencies and trigger testing protocols:
```bash
npm install
npm test
```
EOF

echo "Initialization complete! Your connected multi-part repository has been successfully generated."

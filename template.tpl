___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Term Sanitizer by Luis Araujo",
  "description": "This term sanitizer is an efficient and robust template that processes text strings, applying a series of transformations to ensure their standardization and cleanliness.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "originalTerm",
    "displayName": "Term to sanitize",
    "simpleValueType": true,
    "help": "Enter the variable or term to be sanitized."
  },
  {
    "type": "CHECKBOX",
    "name": "removeSpaces",
    "checkboxText": "removeSpaces",
    "simpleValueType": true,
    "defaultValue": false,
    "subParams": [
      {
        "type": "TEXT",
        "name": "separatorType",
        "displayName": "separatorType",
        "simpleValueType": true,
        "defaultValue": "-",
        "enablingConditions": [
          {
            "paramName": "removeSpaces",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "help": "Enter the character to be used for replacing spaces in the text. Example: \u0027-\u0027, \u0027_\u0027, or any other symbol."
      }
    ],
    "help": "Check this option to replace spaces in the text with the chosen separator."
  },
  {
    "type": "RADIO",
    "name": "caseOption",
    "displayName": "caseOption",
    "radioItems": [
      {
        "value": "lowercase",
        "displayValue": "lowerCase",
        "help": ""
      },
      {
        "value": "normalcase",
        "displayValue": "normalCase",
        "help": ""
      },
      {
        "value": "uppercase",
        "displayValue": "upperCase"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "lowercase",
    "help": "Choose whether the final text should be converted to uppercase (UPPERCASE) or lowercase (lowercase)."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const term = data.originalTerm;

const removeSpaces = data.removeSpaces || false;
const separatorType = data.separatorType || '-';
const caseOption = data.caseOption || 'lowercase';

if (typeof term !== 'string') {
  return '';
}

let sanitizedTerm = term.trim();

const accentsMap = {
  'á': 'a', 'à': 'a', 'ã': 'a', 'â': 'a', 'ä': 'a',
  'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
  'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
  'ó': 'o', 'ò': 'o', 'õ': 'o', 'ô': 'o', 'ö': 'o',
  'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
  'ç': 'c', 'ñ': 'n', '$': 's',
  'Á': 'A', 'À': 'A', 'Ã': 'A', 'Â': 'A', 'Ä': 'A',
  'É': 'E', 'È': 'E', 'Ê': 'E', 'Ë': 'E',
  'Í': 'I', 'Ì': 'I', 'Î': 'I', 'Ï': 'I',
  'Ó': 'O', 'Ò': 'O', 'Õ': 'O', 'Ô': 'O', 'Ö': 'O',
  'Ú': 'U', 'Ù': 'U', 'Û': 'U', 'Ü': 'U',
  'Ç': 'C', 'Ñ': 'N'
};

let cleanedTerm = '';
for (let i = 0; i < sanitizedTerm.length; i++) {
  const char = sanitizedTerm[i];
  cleanedTerm += (char === '_' || char === '-') ? ' ' : accentsMap[char] || char;
}

let sanitizedCleanedTerm = '';
for (let i = 0; i < cleanedTerm.length; i++) {
  const char = cleanedTerm[i];
  if (
    (char >= 'a' && char <= 'z') || 
    (char >= 'A' && char <= 'Z') || 
    (char >= '0' && char <= '9') || 
    char === ' '
  ) {
    if (char === ' ' && sanitizedCleanedTerm[sanitizedCleanedTerm.length - 1] === ' ') {
      continue;
    }
    sanitizedCleanedTerm += char;
  }
}

if (removeSpaces) {
  sanitizedCleanedTerm = sanitizedCleanedTerm.split(' ').join(separatorType);
}

if (caseOption === 'lowercase') {
  sanitizedCleanedTerm = sanitizedCleanedTerm.toLowerCase();
} else if (caseOption === 'uppercase') {
  sanitizedCleanedTerm = sanitizedCleanedTerm.toUpperCase();
}

return sanitizedCleanedTerm;


___TESTS___

scenarios:
- name: true, hyphen, lowercase
  code: |
    const mockData = {
      originalTerm: "Olá Mundo 2025!",
      removeSpaces: true,
      separatorType: "-",
      caseOption: "lowercase"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("ola-mundo-2025");
- name: false, space, lowercase
  code: |
    const mockData = {
      originalTerm: "Olá Mundo 2025!",
      removeSpaces: false,
      separatorType: "-",
      caseOption: "lowercase"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("ola mundo 2025");
- name: true, underline, uppercase
  code: |
    const mockData = {
      originalTerm: "Olá Mundo 2025!",
      removeSpaces: true,
      separatorType: "_",
      caseOption: "uppercase"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("OLA_MUNDO_2025");
- name: false, space, uppercase
  code: |
    const mockData = {
      originalTerm: "Olá-Mundo 2025!",
      removeSpaces: false,
      separatorType: "-",
      caseOption: "uppercase"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("OLA MUNDO 2025");
- name: true, hyphen, normalcase
  code: |
    const mockData = {
      originalTerm: "Olá-Mundo 2025!",
      removeSpaces: true,
      separatorType: "-",
      caseOption: "normal"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("Ola-Mundo-2025");
- name: false, space, normalcase
  code: |
    const mockData = {
      originalTerm: "Olá-Mundo 2025!",
      removeSpaces: false,
      separatorType: "-",
      caseOption: "normalcase"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("Ola Mundo 2025");
- name: empty term
  code: |
    const mockData = {
      originalTerm: "",
      removeSpaces: true,
      separatorType: "-",
      caseOption: "lowercase"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("");
- name: non-string term test
  code: |
    const mockData = {
      originalTerm: 121,
      removeSpaces: false,
      separatorType: "-",
      caseOption: "lowercase"
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo("");
setup: ''


___NOTES___

Created on 23/12/2024, 12:59:43



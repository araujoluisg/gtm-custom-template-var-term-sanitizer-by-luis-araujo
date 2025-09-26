
# Term Sanitizer by Luis Araujo

**Term Sanitizer** is a highly efficient and robust custom template designed to process text strings by applying a series of transformations to ensure consistency, standardization, and cleanliness.

---

## 🔧 Features

### Always-applied transformations

The following sanitization steps are applied automatically:

* **Accent and Special Character Removal**

  * Replaces accented characters (e.g., *á, é, ç*) with their non-accented equivalents (*a, e, c*).
  * Removes special characters that are not letters, numbers, or spaces.

* **Unique Spaces Guarantee**

  * Multiple consecutive spaces are reduced to a single space.

* **Invalid Character Cleaning**

  * Removes any characters that are not letters, numbers, or spaces (except the separator when configured).

---

### 👤 User Customizations

* **Space Removal**

  * Can be enabled or disabled via a checkbox.
  * When enabled, spaces are replaced with a **custom separator** defined by the user.
  * When disabled, original spaces remain untouched.

* **Custom Separator**

  * The user can define the separator character (e.g., `-`, `_`, or any other).

* **Text Case Format**

  * Options available:

    * **Lowercase**
    * **Normal case**
    * **Uppercase**

---

## 🚀 Usage

```js
// Example: sanitizing a string
const sanitizedCleanedTerm = originalTerm("[{(HeLLo, the WoRld: It's âmázing)}]", {
  removeSpaces: true,
  separatorType: "-",
  caseOption: "lowercase"
});

console.log(sanitizedCleanedTerm); 
// Output: hello-the-world-its-amazing
```

---

## 📌 Benefits

* Guarantees clean, standardized text output.
* Easy to configure and adapt for different use cases.
* Ensures consistent handling of accents, spacing, and casing.


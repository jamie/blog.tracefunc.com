import js from "@eslint/js";

export default [
  js.configs.recommended,
  {
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        console: "readonly",
        process: "readonly",
      },
    },
    rules: {
      "no-console": "off",
      "no-useless-escape": "off",
    },
  },
  {
    // Generated and managed by Bridgetown; edit esbuild.config.js instead.
    ignores: ["config/esbuild.defaults.js"],
  },
];

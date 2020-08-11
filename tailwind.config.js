module.exports = {
  purge: {
    mode: "production",
    content: [
      "./src/**/*.css",
      "./src/**/*.erb",
      "./src/**/*.html",
      "./src/**/*.liquid",
      "./src/**/*.md",
      "./output/**/*.html",
    ],
  },
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
};
